From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 03/10] define ELF notes for adding to a boot image
Date: Tue, 26 Jun 2007 13:18:30 -0700
Message-ID: <20070626131830.9a4d4ae6.akpm@linux-foundation.org>
References: <20070615004818.424726597@goop.org>
	<20070615005012.882738673@goop.org> <4672BC5B.1040502@zytor.com>
	<4672C0FF.9080209@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4672C0FF.9080209@goop.org>
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
Cc: Xen-Devel <xen-devel@lists.xensource.com>, lkml <linux-kernel@vger.kernel.org>, v12n <virtualization@lists.linux-foundation.org>, Vivek Goyal <vgoyal@in.ibm.com>, "Eric W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 15 Jun 2007 09:40:31 -0700
Jeremy Fitzhardinge <jeremy@goop.org> wrote:

> H. Peter Anvin wrote:
> > Jeremy Fitzhardinge wrote:
> >   
> >> +#define EIN_PROGRAM_CHECKSUM	3 /* ip style checksum of the memory image. */
> >>     
> >
> > Why on earth use one of the weakest verificants in common use?
> 
> I don't know.  I copied this stuff from the original relocatable kernel
> patches; I think this is from Vivek.  Eric, Vivek: is there a specific
> use for these notes?
> 

ping?


Jeremy, I'll duck these patches for now, sorry.  Mainly on
i-already-have-enough-x86-stuff grounds.

There's a bit of overlap between this work and git-newsetup, but nothing
particularly serious-looking.
