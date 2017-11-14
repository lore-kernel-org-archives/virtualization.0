From: Wei Wang <wei.w.wang@intel.com>
Subject: Re: [PATCH v17 6/6] virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_VQ
Date: Tue, 14 Nov 2017 20:02:03 +0800
Message-ID: <5A0ADB3B.4070407__29297.7096666165$1510660792$gmane$org@intel.com>
References: <1509696786-1597-1-git-send-email-wei.w.wang@intel.com>
	<1509696786-1597-7-git-send-email-wei.w.wang@intel.com>
	<5A097548.8000608@intel.com>
	<20171113192309-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20171113192309-mutt-send-email-mst@kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: yang.zhang.wz@gmail.com, kvm@vger.kernel.org, penguin-kernel@I-love.SAKURA.ne.jp, liliang.opensource@gmail.com, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, aarcange@redhat.com, virtio-dev@lists.oasis-open.org, mawilcox@microsoft.com, willy@infradead.org, quan.xu@aliyun.com, Nitesh Narayan Lal <nilal@redhat.com>, Rik van Riel <riel@redhat.com>, cornelia.huck@de.ibm.com, mhocko@kernel.org, linux-kernel@vger.kernel.org, amit.shah@redhat.com, pbonzini@redhat.com, akpm@linux-foundation.org, mgorman@techsingularity.net
List-Id: virtualization@lists.linuxfoundation.org

On 11/14/2017 01:32 AM, Michael S. Tsirkin wrote:
>> - guest2host_cmd: written by the guest to ACK to the host about the
>> commands that have been received. The host will clear the corresponding
>> bits on the host2guest_cmd register. The guest also uses this register
>> to send commands to the host (e.g. when finish free page reporting).
> I am not sure what is the role of guest2host_cmd. Reporting of
> the correct cmd id seems sufficient indication that guest
> received the start command. Not getting any more seems sufficient
> to detect stop.
>

I think the issue is when the host is waiting for the guest to report 
pages, it does not know whether the guest is going to report more or the 
report is done already. That's why we need a way to let the guest tell 
the host "the report is done, don't wait for more", then the host 
continues to the next step - sending the non-free pages to the 
destination. The following method is a conclusion of other comments, 
with some new thought. Please have a check if it is good.

Two new configuration registers in total:
- cmd_reg: the command register, combined from the previous host2guest 
and guest2host. I think we can use the same register for host requesting 
and guest ACKing, since the guest writing will trap to QEMU, that is, 
all the writes to the register are performed in QEMU, and we can keep 
things work in a correct way there.
- cmd_id_reg: the sequence id of the free page report command.

-- free page report:
     - host requests the guest to start reporting by "cmd_reg | 
REPORT_START";
     - guest ACKs to the host about receiving the start reporting 
request by "cmd_reg | REPORT_START", host will clear the flag bit once 
receiving the ACK.
     - host requests the guest to stop reporting by "cmd_reg | REPORT_STOP";
     - guest ACKs to the host about receiving the stop reporting request 
by "cmd_reg | REPORT_STOP", host will clear the flag once receiving the ACK.
     - guest tells the host about the start of the reporting by writing 
"cmd id" into an outbuf, which is added to the free page vq.
     - guest tells the host about the end of the reporting by writing 
"0" into an outbuf, which is added to the free page vq. (we reserve 
"id=0" as the stop sign)

-- ballooning:
     - host requests the guest to start ballooning by "cmd_reg | 
BALLOONING";
     - guest ACKs to the host about receiving the request by "cmd_reg | 
BALLOONING", host will clear the flag once receiving the ACK.


Some more explanations:
-- Why not let the host request the guest to start the free page 
reporting simply by writing a new cmd id to the cmd_id_reg?
The configuration interrupt is shared among all the features - 
ballooning, free page reporting, and future feature extensions which 
need host-to-guest requests. Some features may need to add other feature 
specific configuration registers, like free page reporting need the 
cmd_id_reg, which is not used by ballooning. The rule here is that the 
feature specific registers are read only when that feature is requested 
via the cmd_reg. For example, the cmd_id_reg is read only when "cmd_reg 
| REPORT_START" is true. Otherwise, when the driver receives a 
configuration interrupt, it has to read both cmd_reg and cmd_id 
registers to know what are requested by the host - think about the case 
that ballooning requests are sent frequently while free page reporting 
isn't requested, the guest has to read the cmd_id register every time a 
ballooning request is sent by the host, which is not necessary. If 
future new features follow this style, there will be more unnecessary 
VMexits to read the unused feature specific registers.
So I think it is good to have a central control of the feature request 
via only one cmd register - reading that one is enough to know what is 
requested by the host.


Best,
Wei
