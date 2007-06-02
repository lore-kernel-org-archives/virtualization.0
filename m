From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: Extending boot protocol & bzImage for paravirt_ops
Date: Fri, 01 Jun 2007 17:37:51 -0700
Message-ID: <4660BBDF.1040007@goop.org>
References: <4656FB8F.4090604@goop.org>
	<m14pm0c0m2.fsf@ebiederm.dsl.xmission.com>
	<466087CF.70708@goop.org> <4660924A.2070009@zytor.com>
	<466093E3.4010701@goop.org> <46609636.4050208@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <46609636.4050208@zytor.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Chris Wright <chrisw@sous-sol.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

H. Peter Anvin wrote:
> Well, if we define is as a movable object then it has to be treated as
> such.  It's a protocol definition issue.  If we define it opaque, though
> -- of for that matter, if we don't -- we should define what memory it
> can live in, though.  Right now, the only "available" memory we have is
> end of setup to 0xa0000; the command line is defined to be allocated
> from this memory.
>   

Well, I think we can safely say that its something that's only
meaningful in 32/64-bit mode, so we aren't constrained by the real-mode
address space.

One of my goals in this project is to make the boot image, in some way,
completely define which memory it needs it get started.  That means that
the boot loader can either place things knowing they'll avoid the boot
image and/or definitively know that the image is unloadable.

So I don't think its strictly necessary to pre-define what memory this
object can use, since I think it can be safely determined dynamically.

    J
