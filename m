From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: console lock up
Date: Wed, 11 Jul 2007 21:23:31 +1000
Message-ID: <1184153011.6005.614.camel@localhost.localdomain>
References: <c5d4ac100707100546j17c67b5bhcd9f36fcf9da9b2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <c5d4ac100707100546j17c67b5bhcd9f36fcf9da9b2@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Sam Abed <samabed@gmail.com>
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 2007-07-10 at 22:46 +1000, Sam Abed wrote:
> hello,
>   I am using 2.6.21, lguest-2.6.21-307.patch.gz and an image from
> http://uml.nagafix.co.uk/Fedora7/Fedora7-x86-root_fs.bz2
> 
> the console hangs, is this expected or caused by the image? I can
> still ssh to it or if I boot in single user mode the console is
> available but running init3 and it's hung.

Hi Sam,

	Thanks for the bug report!  I can't even figure out how to get
networking running under that image (not a RH person, sorry).  When I
boot in single user mode and ifconfig up manually then "telinit 3" it
seems OK.

	Note that it does not seem to start a getty for runlevel 3, so you
can't log in, but that's not an lguest issue (you should be able to ssh
in).

> also is it possible to get the last gz patch released for 2.6.21?

	Unfortunately it's a PITA to do and test; I think my time is better
spent concentrating on the 2.6.23 release, and not backporting.

Sorry,
Rusty.


> _______________________________________________
> Virtualization mailing list
> Virtualization@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/virtualization
