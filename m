From: Glauber de Oliveira Costa <gcosta@redhat.com>
Subject: Re: [kvm-devel] [PATCH/RFC 0/2] CPU hotplug virtio driver
Date: Wed, 09 Jan 2008 12:12:43 -0200
Message-ID: <4784D65B.80209__30698.2153597803$1199888317$gmane$org@redhat.com>
References: <11998740663306-git-send-email-gcosta@redhat.com>
	<4784A50E.6050302@qumranet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4784A50E.6050302@qumranet.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Avi Kivity <avi@qumranet.com>
Cc: kvm-devel@lists.sourceforge.net, marcelot@redhat.com, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Avi Kivity wrote:
> Glauber de Oliveira Costa wrote:
>> I'm sending a first draft of my proposed cpu hotplug driver for 
>> kvm/virtio
>> The first patch is the kernel module, while the second, the userspace 
>> pci device.
>>
>> The host boots with the maximum cpus it should ever use, through the 
>> -smp parameter.
>> Due to real machine constraints (which qemu copies), i386 does not 
>> allow for any addition
>> of cpus after boot, so this is the most general way.
>>
>> I do however, include an "attempt_buffer" in the userspace part. It's 
>> purpose is to
>> allow tools like virt-manager to set a max_cpus (-smp), and a desired 
>> number of cpus
>> in their configuration files. (and AFAICT, there's is no easy way for 
>> them to tell when the
>> backend driver is up and running)
>>
>> Other than that, it should be pretty much straightforward.
>>
>> Looking forward for your comments
>>
>>   
> 
> I would much prefer to see cpu hotplug implemented via acpi.  Such an 
> implementation would work on older kernels without change, and will also 
> work with other operating systems.  It isn't a high-speed interface so 
> virtio doesn't buy us anything.
> 
> Linux appears to support it (CONFIG_ACPI_HOTPLUG_CPU) so all that's 
> needed is the host side support (likely qemu/bios only).  Of course 
> hacking on acpi is fun, if you're the kind of person than enjoys dental 
> surgery.
> 
Being acpi so that fun, how can it be that virtio don't by us _anything_ ?
