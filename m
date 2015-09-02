From: "Nakajima, Jun" <jun.nakajima@intel.com>
Subject: Re: rfc: vhost user enhancements for vm2vm communication
Date: Tue, 1 Sep 2015 17:01:07 -0700
Message-ID: <CAL54oT1pcDv0xHoBshvWurePLYK2+eCgfzODh9KZj3Pe_5FB9Q@mail.gmail.com>
References: <20150831160655-mutt-send-email-mst@redhat.com>
	<55E55539.4030008@siemens.com>
	<20150901104914-mutt-send-email-mst@redhat.com>
	<55E56BD8.5010202@siemens.com>
	<20150901121743-mutt-send-email-mst@redhat.com>
	<55E5B1A8.9080506@siemens.com>
	<20150901172239-mutt-send-email-mst@redhat.com>
	<55E5C58D.6000104@siemens.com>
	<20150901184922-mutt-send-email-mst@redhat.com>
	<55E5D22C.6020108@siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <55E5D22C.6020108@siemens.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: virtio-dev@lists.oasis-open.org, "Michael S. Tsirkin" <mst@redhat.com>, Claudio.Fontana@huawei.com, qemu-devel@nongnu.org, Linux Virtualization <virtualization@lists.linux-foundation.org>, Varun Sethi <Varun.Sethi@freescale.com>, opnfv-tech-discuss@lists.opnfv.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Sep 1, 2015 at 9:28 AM, Jan Kiszka <jan.kiszka@siemens.com> wrote:
> On 2015-09-01 18:02, Michael S. Tsirkin wrote:
...
>> You don't need to be able to map all guest memory if you know
>> guest won't try to allow device access to all of it.
>> It's a question of how good is the bus address allocator.
>
> But those BARs need to allocate a guest-physical address range as large
> as the other guest's RAM is, possibly even larger if that RAM is not
> contiguous, and you can't put other resources into potential holes
> because VM2 does not know where those holes will be.
>

I think you can allocate such guest-physical address ranges
efficiently if each BAR sets the base of each memory region reported
by VHOST_SET_MEM_TABLE, for example.  The issue is that we would need
to 8 (VHOST_MEMORY_MAX_NREGIONS) of them vs. 6 (defined by PCI-SIG).

-- 
Jun
Intel Open Source Technology Center
