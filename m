From: Dave Hansen <dave@linux.vnet.ibm.com>
Subject: Re: RFC: I/O bandwidth controller
Date: Wed, 06 Aug 2008 08:48:08 -0700
Message-ID: <1218037688.10907.85.camel__31413.8920665302$1218038039$gmane$org@nimitz>
References: <20080804.175126.193692178.ryov@valinux.co.jp>
	<1217870433.20260.101.camel@nimitz>
	<1217985189.3154.57.camel@sebastian.kern.oss.ntt.co.jp>
	<20080806.151824.104049463.ryov@valinux.co.jp>
	<1218004892.3950.12.camel@sebastian.kern.oss.ntt.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1218004892.3950.12.camel@sebastian.kern.oss.ntt.co.jp>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Fernando Luis =?ISO-8859-1?Q?V=E1zquez?= Cao <fernando@oss.ntt.co.jp>
Cc: xen-devel@lists.xensource.com, uchida@ap.jp.nec.com, containers@lists.linux-foundation.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, dm-devel@redhat.com, agk@sourceware.org, ngupta@google.com, righi.andrea@gmail.com
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 2008-08-06 at 15:41 +0900, Fernando Luis V=E1zquez Cao wrote:
> > I agree with your plan.
> > We keep bio-cgroup improving and porting to the latest kernel.
> Having more users of bio-cgroup would probably help to get it merged, so
> we'll certainly send patches as soon as we get our cfq prototype in
> shape.

I'm confused.  Are these two of the competing controllers?  Or are the
complementary in some way?

-- Dave
