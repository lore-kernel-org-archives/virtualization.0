From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Vmware crashes if compress/misc.c scrolls?
Date: Wed, 20 Jun 2007 16:44:11 -0700
Message-ID: <4679BBCB.2000202@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

I just got the following message on the syslinux mailing list:

> 2. On some platforms (vmware for example :), READING from the video memory
>    in the 32bit mode is impossible (causes an exeption). Taking in to account
>    that the scroll function in ilinux/arch/i386/boot/compressed/misc.c
>    works using a memcpy of the video memory, when the linux bootsector is given
>    control and the cursor is at the end of the screen (-1-2 lines) an exception is
>    arisen and in the presence of it's handler in the bootloader the system halts.
>    Both lilo and grub handle this situation - the cursor is always somewhere at the
>    middle of the screen when the control is given to the linux bootsector.
>    When using pxelinux taking in to account that the PXE bios prints out the
>    presence of the second initramfs which causes the screen to scroll and the bug
>    to appear :)
>    A very simple solution - the screen is cleared before giving control to the
>    linux bootsector (in the patch).

First of all, is this actually true?  This seems like a monumental screwup.

Second, assuming it is true, what should be done about it?  The notion
that the bootloader should erase the screen is ridiculous since we spend
a lot of effort maintaining the screen context from 16-bit code.

I see a couple of options:

a. Do nothing.  It's a Vmware bug, let the users bug Vmware and get an
   updated version.
b. Detect Vmware versions that are affected (how?) and suppress output.
c. Don't attempt to scroll in this code, and instead wrap around the
   screen (presumably clearing the rest of the line.)
d. Blindly assume hardware scrolling works, instead of doing
   copy-to-scroll.  Although I have seen craptops on which hardware
   scrolling is broken, it's hardly critical messages we're dealing with
   here.  A bug for a bug...

	-hpa
