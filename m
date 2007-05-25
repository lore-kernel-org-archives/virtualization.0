From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Extending boot protocol & bzImage for paravirt_ops
Date: Fri, 25 May 2007 16:06:55 +0100
Message-ID: <4656FB8F.4090604@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1762775AbXEYPHR@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Eric W. Biederman" <ebiederm@xmission.com>, Rusty Russell <rusty@rustcorp.com.au>, Chris Wright <chrisw@sous-sol.org>, "H. Peter Anvin" <hpa@zytor.com>
Cc: Virtualization Mailing List <virtualization@lists.osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

Well, it seems to be about time to have this conversation again.

A rough overview of the previous thread and requirements is:

   1. bzImage would not be a bare ELF file, but it would contain an ELF
      header+file within it
   2. We need some way to add extra ELF notes into that ELF file
   3. We use a "paravirtualized" bootloader type, with some other field
      to determine which hypervisor we're dealing with
   4. We need to extend the boot info structure to include a pointer to
      some other hypervisor-specific information
   5. When started at the 32-bit entrypoint, bzImage expects:
         1. 32-bit mode
         2. running in any ring (and ring implies nothing about the
            environment)
         3. all segment registers are loaded with flat 4G segments
         4. there may or may not be a valid GDT (segment registers must
            not be reloaded until GDT is explicitly set up)
         5. interrupts disabled
         6. paging may or may not be enabled; if enabled, it has 1:1
            mappings where the ELF file's Phdrs say they should be
   6. When bzImage starts the kernel-proper, it works out how to choose
      the appropriate boot path based on the boot info structure in %esi

How much of this already exists?  Is there enough to start prototyping with?

What was the problem with ELF bzImage?  Is it confirmed to be
problematic, or just suspected?  Could we end up using a plain ELF file
(which would be easiest for me, since I think the existing ELF domain
builder could pretty much deal with that as-is).

    J
