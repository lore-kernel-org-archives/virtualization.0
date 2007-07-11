From: "Sam Abed" <samabed@gmail.com>
Subject: Fwd: console lock up
Date: Wed, 11 Jul 2007 22:48:26 +1000
Message-ID: <c5d4ac100707110548h3df20bceq32835225db8f4b5d@mail.gmail.com>
References: <c5d4ac100707100546j17c67b5bhcd9f36fcf9da9b2@mail.gmail.com>
	<1184153011.6005.614.camel@localhost.localdomain>
	<c5d4ac100707110546n3b26b60ayc4884f91a45517e1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <c5d4ac100707110546n3b26b60ayc4884f91a45517e1@mail.gmail.com>
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
To: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

oops forgot to reply all

---------- Forwarded message ----------
From: Sam Abed <samabed@gmail.com>
Date: Jul 11, 2007 10:46 PM
Subject: Re: console lock up
To: Rusty Russell <rusty@rustcorp.com.au>


Hello,
  Thanks for the taking the time to reply

On 7/11/07, Rusty Russell <rusty@rustcorp.com.au> wrote:
> On Tue, 2007-07-10 at 22:46 +1000, Sam Abed wrote:
> > hello,
> >   I am using 2.6.21, lguest-2.6.21-307.patch.gz and an image from
> > http://uml.nagafix.co.uk/Fedora7/Fedora7-x86-root_fs.bz2
> >
> > the console hangs, is this expected or caused by the image? I can
> > still ssh to it or if I boot in single user mode the console is
> > available but running init3 and it's hung.
>
> Hi Sam,
>
>         Thanks for the bug report!  I can't even figure out how to get
> networking running under that image (not a RH person, sorry).  When I
> boot in single user mode and ifconfig up manually then "telinit 3" it
> seems OK.

for me, I can't type into the console, maybe hangs is not the right
word, but it's definitely not working.
at the end of the email is a screen scrap, the vcs errors and all

in case you are curious about how RH does it ...
sh-3.2# cat /etc/sysconfig/network-scripts/ifcfg-eth0
DEVICE=eth0
#BOOTPROTO=dhcp
ONBOOT=yes
TYPE=Ethernet
IPADDR=192.168.1.2
NETMASK=255.255.255.0
NETWORK=192.168.1.0
BROADCAST=192.168.1.255
GATEWAY=192.168.1.1

>
>         Note that it does not seem to start a getty for runlevel 3, so you
> can't log in, but that's not an lguest issue (you should be able to ssh
> in).
I would have though this line does the trick
sh-3.2# grep getty /etc/inittab
# Run gettys in standard runlevels
1:1235:respawn:/sbin/mingetty tty0
2:1235:respawn:/sbin/mingetty tty1

I can ssh in, it's a bit annoying not having the console.
>
> > also is it possible to get the last gz patch released for 2.6.21?
>
>         Unfortunately it's a PITA to do and test; I think my time is better
> spent concentrating on the 2.6.23 release, and not backporting.
>

oh, I appreciate that, I mean the last one that was published on the
website for the 2.6.21 version.

> Sorry,
> Rusty.
>
>
> > _______________________________________________
> > Virtualization mailing list
> > Virtualization@lists.linux-foundation.org
> > https://lists.linux-foundation.org/mailman/listinfo/virtualization
>
>

sh-3.2# telinit 3
INIT: Switching to runlevel: 3
INIT: Sending processes the TERM signal
INIT: Sending processes the KILL signal
Starting sshd: [  OK  ]
Starting crond: [  OK  ]
[   23.760000] DEV: registering device: ID = 'vcs1'
[   23.760000] PM: Adding info for No Bus:vcs1
[   23.760000] DEV: registering device: ID = 'vcsa1'
[   23.760000] PM: Adding info for No Bus:vcsa1
[   23.760000] DEV: Unregistering device. ID = 'vcs1'
[   23.760000] PM: Removing info for No Bus:vcs1
[   23.770000] device_create_release called for vcs1
[   23.770000] DEV: Unregistering device. ID = 'vcsa1'
[   23.770000] PM: Removing info for No Bus:vcsa1
[   23.770000] device_create_release called for vcsa1
[   23.770000] DEV: registering device: ID = 'vcs1'
[   23.770000] PM: Adding info for No Bus:vcs1
[   23.770000] DEV: registering device: ID = 'vcsa1'
[   23.770000] PM: Adding info for No Bus:vcsa1
