From: Nicholas Mc Guire <der.herr@hofr.at>
Subject: Re: lguest problem on boot of guest kernel
Date: Sat, 2 Jun 2007 15:24:10 +0200 (CEST)
Message-ID: <Pine.LNX.4.60.0706021455390.486@rtl14.hofr.at>
References: <Pine.LNX.4.60.0706011704240.786@rtl14.hofr.at>
	<1180780059.9228.72.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1180780059.9228.72.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

>
> 	You're the second one to hit this in as many days.  I just uploaded an
> updated patch, but the summary is that you have to turn off COMPAT_VDSO
> for the 2.6.21 patch.  (You can actually leave it on in the host, it's
> just the guests...)
>

that did it - thanks!
actually COMPAT_VDSO is not needed post glibc-2.3.3 any way.

another little strangeness I found on booting is that multiple init 
processes are reported (busybox 1.2.2.1 based FS)

hosta $ ps auxw
    PID  Uid     VmSize Stat Command
      1 root        508 S   init
      2 root            SWN [ksoftirqd/0]
      3 root            SW  [watchdog/0]
      4 root            SW< [events/0]
      5 root            SW< [khelper]
      6 root            SW< [kthread]
     69 root            SW< [kblockd/0]
     70 root            SW< [ata/0]
     71 root            SW< [ata_aux]
     72 root            SW< [ksuspend_usbd]
     75 root            SW< [khubd]
     77 root            SW< [kseriod]
     88 root            SW< [khpsbpkt]
    104 root            SW  [pdflush]
    105 root            SW  [pdflush]
    106 root            SW< [kswapd0]
    107 root            SW< [aio/0]
    690 root            SW< [khvcd]
    781 root            SW< [kpsmoused]
    784 root            SW< [kondemand/0]
    801 root        212 S   telnetd
    803 nobody      212 S   httpd -h /tmp -c /etc/httpd.conf -u nobody
    804 root        664 S   -sh
    805 root        252 S   init
    808 root        252 S   init
    811 root        252 S   init
    826 root        524 R   ps auxw
hosta $

   same filesystem booted under UML does not exhibit these processes, they
are also unkillable and these processes actually report a uniq VmSize.
any idea what they are? /proc/80{5,8,11}/* really does look identical to 
/proc/1/* (except for statm/status/smaps).

   Other than this nothing found to fuss about ;)

thanks for a cool new playground!
hofrat
