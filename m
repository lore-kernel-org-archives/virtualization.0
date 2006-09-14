From: Chris Wright <chrisw@sous-sol.org>
Subject: Re: Xen status
Date: Wed, 13 Sep 2006 18:59:15 -0700
Message-ID: <20060914015915.GP10348@sequoia.sous-sol.org>
References: <45088D19.5070801@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <45088D19.5070801@goop.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Chris Wright <chrisw@sous-sol.org>, Ian Campbell <Ian.Campbell@XenSource.com>, Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

* Jeremy Fitzhardinge (jeremy@goop.org) wrote:
> Well, the PDA stuff took a bit longer to settle down than I would have =

> hoped, but it seems fairly sound now.
> =

> I just committed the changes needed to make Xen happy with the PDA, =

> which means making sure an appropriate GDT is set up early enough.
> =

> I also seem to have avoided most of the APIC issues under Xen by simply =

> making the cpuid not report the presence of an APIC.
> =

> With these in place, things are getting fairly far, but not to =

> usermode.  It often gets as far as trying to mount root, but it fails; I =

> haven't investigated that yet.  But it also frequently crashes before =

> then, depending on when it gets an interrupt.  I'm trying to work out =

> what's happening here, but the symptom is eip =3D=3D 0x00000001 (!).

Haven't seen that one.

> Chris, what local hacks do you have in your tree?

Essentially all the local hacks I have are for debugging.  There was
one bit which was just for apic clock setup.  But the symptom w/out
that was a hang, not a crash.  They're also on a remote machine that
has apparently died.  Re-tooling locally ATM.

thanks,
-chris
