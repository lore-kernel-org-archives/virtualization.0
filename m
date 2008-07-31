From: "Alexey Eremenko" <al4321@gmail.com>
Subject: Re: [Xen-users] Re: [Xen-devel] State of Xen in upstream Linux
Date: Thu, 31 Jul 2008 20:19:03 +0200
Message-ID: <7fac565a0807311119p55e534f1hc15005aea46671a2@mail.gmail.com>
References: <48910C99.10606@goop.org> <20080731090845.GH23888@redhat.com>
	<ed123fa30807311054p4965f43bod78dafa6626c9c2d@mail.gmail.com>
	<4891FFBA.1020702@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4891FFBA.1020702@goop.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Virtualization Mailing List <virtualization@lists.osdl.org>, Grant McWilliams <grantmasterflash@gmail.com>, "Daniel P. Berrange" <berrange@redhat.com>, Xen-devel <xen-devel@lists.xensource.com>, xen-users@lists.xensource.com
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Jul 31, 2008 at 8:08 PM, Jeremy Fitzhardinge <jeremy@goop.org> wrote:
> Grant McWilliams wrote:
>>
>>
>>     > Fedora 9's kernel-xen package has been based on the mainline
>>     kernel from
>>     > the outset, but it is still packaged as a separate kernel.
>>      kernel-xen
>>     > has been dropped from rawhide (what will become Fedora 10), and
>>     all Xen
>>     > support - both 32 and 64 bit - has been rolled into the main kernel
>>     > package.
>>
>>
>> Does this mean in the future all Fedora kernels will be Xen kernels?
>> Is this wise? If I try to run VirtualBox on a Xen kernel the machine
>> will reboot. If the Vbox module is loaded at runtime it will reboot
>> forever. Yes, I know it's a Vbox issue but what about KVM. Can we run
>> KVM on a Xen kernel?
>>
>> Or am I reading this completely wrong?
>
> If you boot the kernel on bare hardware, the Xen parts of the kernel
> will basically be switched off, and play no part in runtime.  All
> hardware features and device drivers should be available as normal.  I
> run kvm on pvops/xen kernels all the time.
>
> If you boot the kernel under Xen, then VT/SVM will not be available, and
> any kernel module which tries to use them - like kvm or (I presume)
> virtualbox - should quietly get out of the way.  If they cause the
> domain to crash, then that's a bug in those modules.
>
> If by "the machine will reboot" you mean that the whole system crashes,
> then that's definitely a bug in Xen which should be fixed.  It should
> never be possible for a domU to crash the system.
>
>    J
> _______________________________________________
> Virtualization mailing list
> Virtualization@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/virtualization
>

Jeremy: Mr. Grant speaking about the future where Linux (2.6.28?)
mainline kernel will support Xen Dom0, not kernel 2.6.27, which only
improves Xen DomU.

And I agree with Grant, that if Linux mainline will have Dom0
included, that may cause problems for all kinds of drivers.

As for 2.6.27, it shouldn't cause any new problems.

-- 
-Alexey Eromenko "Technologov"
