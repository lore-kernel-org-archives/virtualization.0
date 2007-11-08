From: Avi Kivity <avi@qumranet.com>
Subject: Re: Use of virtio device IDs
Date: Thu, 08 Nov 2007 08:37:14 +0200
Message-ID: <4732AE9A.4070701__11839.6416808993$1194504013$gmane$org@qumranet.com>
References: <4730A15A.6070001@us.ibm.com> <4730B753.2000901@us.ibm.com>
	<4731334A.6090405@gmail.com> <47314FBD.1070505@qumranet.com>
	<47322262.8000101@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <47322262.8000101@gmail.com>
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
>
>> PCI means that you can reuse all of the platform's infrastructure for
>> irq allocation, discovery, device hotplug, and management.
>>     
>
> Its tempting to use, yes.  However, most of that infrastructure is
> completely inappropriate for a PV implementation, IMHO.  

Why?

> You are
> probably better off designing something that is PV specific instead of
> shoehorning it in to fit a different model (at least for the things I
> have in mind).  

Well, if we design our pv devices to look like hardware, they will fit
quite well.  Both to the guest OS and to user's expectations.

> Its not a heck of a lot of code to write a pv-centric
> version of these facilities.
>
>   

It is.  Especially if you consider Windows and a gazillion versions of
deployed, non-pv-capable Linux systems.  For pv-friendly newer Linux,
it's probably doable, but why?

Look at the mess Xen finds itself in.

>> You can write it for new guests but backporting it to older guests will be a
>> huge task.
>>
>> We will support non-pci for s390, but in order to support Windows and
>> older Linux PCI is necessary.
>>     
>
> I don't know if I would agree with "necessary".  "Easier" perhaps. ;) By
> definition once you are PV you are hypervisor aware.  Now its just a
> matter of plugging in the appropriate plumbing to bridge the hypervisor
> to the guest-os.  Some might be easier than others, sure.  But all
> should be extensible to a degree.
>
>   

It's "necessary" in a pragmatic sense: we want to deliver drivers that
provide features for a wide variety of guests in a reasonable
timeframe.  And that means no rewriting guest OS infrastructure.


-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.
