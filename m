From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH 10/28] i386: map enough initial memory to create lowmem
 mappings
Date: Wed, 25 Apr 2007 17:55:21 -0700
Message-ID: <462FF879.10206@goop.org>
References: <4627DDAD.4070805@redhat.com> <4627E099.209@goop.org> <m1abwwqiof.fsf@ebiederm.dsl.xmission.com> <462FC8CD.1030505@goop.org> <m11wi8qflo.fsf@ebiederm.dsl.xmission.com> <462FD0EF.5050706@goop.org> <m1tzv4p079.fsf@ebiederm.dsl.xmission.com> <462FDBB4.8020604@goop.org> <m14pn4owpy.fsf@ebiederm.dsl.xmission.com> <462FE728.5060802@goop.org> <20070426003337.GB2819@sequoia.sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752029AbXDZAyr@vger.kernel.org>
In-Reply-To: <20070426003337.GB2819@sequoia.sous-sol.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Chris Wright <chrisw@sous-sol.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Chuck Ebbert <cebbert@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@suse.de>, Andrew Morton <akpm@linux-foundation.org>, virtualization@lists.osdl.org, lkml <linux-kernel@vger.kernel.org>, Zachary Amsden <zach@vmware.com>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Chris Wright wrote:
> I was using real hardware with your .config when I reproduced it.
>   

Yes, I first found it on real hardware. I haven't tested my fix on real
hardware yet, but it seems OK on kvm.

J
