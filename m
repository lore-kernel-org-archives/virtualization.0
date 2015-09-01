From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: rfc: vhost user enhancements for vm2vm communication
Date: Tue, 1 Sep 2015 11:11:52 +0200
Message-ID: <55E56BD8.5010202@siemens.com>
References: <20150831160655-mutt-send-email-mst@redhat.com>
	<55E55539.4030008@siemens.com>
	<20150901104914-mutt-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20150901104914-mutt-send-email-mst@redhat.com>
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

On 2015-09-01 10:01, Michael S. Tsirkin wrote:
> On Tue, Sep 01, 2015 at 09:35:21AM +0200, Jan Kiszka wrote:
>> Leaving all the implementation and interface details aside, this
>> discussion is first of all about two fundamentally different approaches:
>> static shared memory windows vs. dynamically remapped shared windows (a
>> third one would be copying in the hypervisor, but I suppose we all agree
>> that the whole exercise is about avoiding that). Which way do we want or
>> have to go?
>>
>> Jan
> 
> Dynamic is a superset of static: you can always make it static if you
> wish. Static has the advantage of simplicity, but that's lost once you
> realize you need to invent interfaces to make it work.  Since we can use
> existing IOMMU interfaces for the dynamic one, what's the disadvantage?

Complexity. Having to emulate even more of an IOMMU in the hypervisor
(we already have to do a bit for VT-d IR in Jailhouse) and doing this
per platform (AMD IOMMU, ARM SMMU, ...) is out of scope for us. In that
sense, generic grant tables would be more appealing. But what we would
actually need is an interface that is only *optionally* configured by a
guest for dynamic scenarios, otherwise preconfigured by the hypervisor
for static setups. And we need guests that support both. That's the
challenge.

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux
