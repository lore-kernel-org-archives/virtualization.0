From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [patch rfc wip] first cut of ELF bzImage
Date: Thu, 31 May 2007 18:12:38 +1000
Message-ID: <1180599158.11133.34.camel@localhost.localdomain>
References: <465E78D2.9080609@goop.org> <465E7CA2.6090201@zytor.com>
	<465E7EC0.6080108@goop.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <465E7EC0.6080108@goop.org>
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
Cc: Virtualization Mailing List <virtualization@lists.osdl.org>, Vivek Goyal <vgoyal@in.ibm.com>, "Eric W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 2007-05-31 at 00:52 -0700, Jeremy Fitzhardinge wrote:
> H. Peter Anvin wrote:
> >   Furthermore,
> > there are *definitely* virtual environments which would be much happier
> > to be able to decompress in host space.  The decompressor doesn't run
> > well in many simulators.
> 
> I'm not sure why you say that.  Rusty managed to get unmodified
> bzImage's booting in lguest within a few hours of hacking.  I don't
> expect Xen would be much different.

Yes, it only required V=P mappings and skipping over the cli & segment
reloads.

It's becoming pretty clear that booting with V=P mappings is in fact the
right thing to do, so I don't think that's a real restriction.  And
we've discussed the cli and segment reloads already.

I understand the desire to restart from scratch, but I don't think we're
there yet....

Rusty.
