From: Zachary Amsden <zach@vmware.com>
Subject: Re: Xen status
Date: Wed, 13 Sep 2006 17:30:12 -0700
Message-ID: <4508A294.3090200@vmware.com>
References: <45088D19.5070801@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
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
Cc: Chris Wright <chrisw@sous-sol.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, Ian Campbell <Ian.Campbell@XenSource.com>
List-Id: virtualization@lists.linuxfoundation.org

Jeremy Fitzhardinge wrote:
> Well, the PDA stuff took a bit longer to settle down than I would have =

> hoped, but it seems fairly sound now.
>
> I just committed the changes needed to make Xen happy with the PDA, =

> which means making sure an appropriate GDT is set up early enough.
>
> I also seem to have avoided most of the APIC issues under Xen by =

> simply making the cpuid not report the presence of an APIC.
>
> With these in place, things are getting fairly far, but not to =

> usermode.  It often gets as far as trying to mount root, but it fails; =

> I haven't investigated that yet.  But it also frequently crashes =

> before then, depending on when it gets an interrupt.  I'm trying to =

> work out what's happening here, but the symptom is eip =3D=3D 0x00000001 =
(!).

Bad patches?  I put code in vmi.c to patch IRET and SYSEXIT EIPs to 0x1 =

and 0x2, respectively, once upon a time.  Maybe it migrated over to you =

somehow?
