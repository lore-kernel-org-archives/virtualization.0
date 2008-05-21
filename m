From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH 0/5] xen pvfb: Para-virtual framebuffer, keyboard and
	pointer driver updates
Date: Wed, 21 May 2008 10:09:14 +0100
Message-ID: <4833E6BA.3060408__45735.3085898378$1211361591$gmane$org@goop.org>
References: <87d4ngm4s4.fsf@pike.pond.sub.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <87d4ngm4s4.fsf@pike.pond.sub.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Markus Armbruster <armbru@redhat.com>
Cc: xen-devel@lists.xensource.com, linux-fbdev-devel@lists.sourceforge.net, adaplas@gmail.com, dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, mingo@redhat.com, Pat Campbell <plc@novell.com>, linux-input@vger.kernel.org, akpm@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Markus Armbruster wrote:
> This is an update to the Linux part of the Xen PVFB.  Linux Xen PVFB
> is a pair of Xen para-virtual frontend device drivers:
> drivers/video/xen-fbfront.c provides a framebuffer, and
> drivers/input/xen-kbdfront provides keyboard and mouse.  Their
> backends run in dom0 user space.
>
> Parts in this patch series:
>
> 1. Enable Xen console by default in domU
> 2. Pointer z-axis (mouse wheel) support
> 3. Module aliases to support module autoloading
> 4. Zero unused bytes in events sent to backend
> 5. Dynamic mode support (screen resizing)
>
> To the best of my knowledge, these patches are independent.  The last
> one needs a bit of trivial merging to apply without the first one.  I
> tested only 1, 1+2, 1+2+3, 1+2+3+4, and the complete series.  I'm
> happy to split this into different parts if that helps.
>   

Thanks Markus,

This looks good.  I'll stick it into my queue and feed it via Ingo when 
I've given it a bit of a test.

Are we happy that the preferred console stuff is now the best solution?  
Does it solve your installer issues?

    J
