From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: rfc: vhost user enhancements for vm2vm communication
Date: Thu, 3 Sep 2015 12:25:27 +0200
Message-ID: <55E82017.3090708@siemens.com>
References: <20150901104914-mutt-send-email-mst@redhat.com>
	<55E56BD8.5010202@siemens.com>
	<20150901121743-mutt-send-email-mst@redhat.com>
	<55E5B1A8.9080506@siemens.com>
	<20150901172239-mutt-send-email-mst@redhat.com>
	<55E5C58D.6000104@siemens.com>
	<20150901184922-mutt-send-email-mst@redhat.com>
	<55E5D22C.6020108@siemens.com>
	<20150903105304-mutt-send-email-mst@redhat.com>
	<55E80308.7070206@siemens.com>
	<20150903112343-mutt-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20150903112343-mutt-send-email-mst@redhat.com>
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
Cc: virtio-dev@lists.oasis-open.org, Claudio.Fontana@huawei.com, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, Varun Sethi <Varun.Sethi@freescale.com>, opnfv-tech-discuss@lists.opnfv.org
List-Id: virtualization@lists.linuxfoundation.org

On 2015-09-03 10:37, Michael S. Tsirkin wrote:
> On Thu, Sep 03, 2015 at 10:21:28AM +0200, Jan Kiszka wrote:
>> On 2015-09-03 10:08, Michael S. Tsirkin wrote:
>>>
>>> IOW if you wish, you actually can create a shared memory device,
>>> make it accessible to the IOMMU and place some or all
>>> data there.
>>>
>>
>> Actually, that could also be something more sophisticated, including
>> virtio-net, IF that device will be able to express its DMA window
>> restrictions (a bit like 32-bit PCI devices being restricted to <4G
>> addresses or ISA devices <1M).
>>
>> Jan
> 
> Actually, it's the bus restriction, not the device restriction.
> 
> So if you want to use bounce buffers in the name of security or
> real-time requirements, you should be able to do this if virtio uses the
> DMA API.

Bounce buffer will only be the simplest option (though fine for low-rate
traffic that we also have in mind, like virtual consoles). Given
properly-sized regions, even if fixed, and the right communication
stacks, you can directly allocate application buffers in those regions
and avoid most to all copying.

In any case, if we manage to address this variation along with your
proposal, that would help tremendously.

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux
