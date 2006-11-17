From: Zachary Amsden <zach@vmware.com>
Subject: Re: pgd_alloc and [cd]tors
Date: Thu, 16 Nov 2006 18:10:20 -0800
Message-ID: <455D1A0C.6010001@vmware.com>
References: <455D0773.2050906@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <455D0773.2050906@goop.org>
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
Cc: Chris Wright <chrisw@sous-sol.org>, Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

Jeremy Fitzhardinge wrote:
> Is there any real use in having a ctor/dtor for the pgd cache?  Given
> that all pgd allocation happens via pgd_alloc/pgd_free, why not just
> fold the [cd]tor in?
>
> I'm asking because Xen wants pgd[3] to be unshared in the PAE case, and
> it looks to me like the easiest way to handle that is by making
> pgd_alloc/free pv-ops and doing the appropriate thing in the Xen code. =

> Would need to sort out the vmalloc mapping replication as well, but I
> think that's pretty straightforward.
>   =


Actually, vmalloc mapping replication is not quite straightforward - you =

have to replicate it under locks and track all pgds using pgd_list if =

you support large pages.

Zach
