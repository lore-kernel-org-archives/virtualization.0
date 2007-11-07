From: Avi Kivity <avi@qumranet.com>
Subject: Re: Use of virtio device IDs
Date: Wed, 07 Nov 2007 07:40:13 +0200
Message-ID: <47314FBD.1070505__7840.73061445287$1194414204$gmane$org@qumranet.com>
References: <4730A15A.6070001@us.ibm.com> <4730B753.2000901@us.ibm.com>
	<4731334A.6090405@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4731334A.6090405@gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Gregory Haskins <gregory.haskins.ml@gmail.com>
Cc: Anthony Liguori <aliguori@us.ibm.com>, linux-kernel@vger.kernel.org, Dor Laor <dor.laor@qumranet.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Gregory Haskins wrote:
> Anthony Liguori wrote:
>
>   
>> Right now, we would have to have every PCI vendor/device ID pair in the
>> virtio PCI driver ID table for every virtio device.
>>     
>
> I realize you guys are probably far down this road in the design
> process,

That doesn't mean we can't change it if it's wrong.

>  but FWIW: This is a major motivation for the reason that the
> IOQ stuff I posted a while back used strings for device identification
> instead of a fixed length, centrally managed namespace like PCI
> vendor/dev-id.  Then you can just name your device something reasonably
> unique (e.g. "qumranet::veth", or "ibm-pvirt-clock").
>   

I dislike strings.  They make it look as if you have a nice extensible
interface, where in reality you have a poorly documented interface which
leads to poor interoperability.

I prefer nice structure where you can see all the limitations immediately.

> (I realize that if you are going to do PCI, you need to make it
> PCI-like.  But I think using PCI in the first place is probably the
> wrong direction.  IMHO, there's really not a lot of reason to be
> constrained by a hardware specification once you decide to go PV.  This
> is even more true if you want to support as many platforms as possible
> (i.e. platforms that don't have PCI natively).
>
>   

PCI means that you can reuse all of the platform's infrastructure for
irq allocation, discovery, device hotplug, and management.  You can
write it for new guests but backporting it to older guests will be a
huge task.

We will support non-pci for s390, but in order to support Windows and
older Linux PCI is necessary.

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.
