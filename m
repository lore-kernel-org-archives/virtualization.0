From: William Lee Irwin III <wli@holomorphy.com>
Subject: Re: [PATCH 4/10] I386 pgd clone under lock fix.patch
Date: Mon, 9 Apr 2007 17:27:50 -0700
Message-ID: <20070410002750.GZ2986@holomorphy.com>
References: <200704100006.l3A06Bao020614@zach-dev.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200704100006.l3A06Bao020614@zach-dev.vmware.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Zachary Amsden <zach@vmware.com>
Cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@muc.de>, Chris Wright <chrisw@sous-sol.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Apr 09, 2007 at 05:06:11PM -0700, Zachary Amsden wrote:
> Copying of the pgd range must happen under the pgd_lock.  This got broken=
 by
> the paravirt changes in the -mm tree.  Badness can result if you copy the=
 pgd
> before being added to the list when splitting or rejoining large pages.
> Signed-off-by: Zachary Amsden <zach@vmware.com>

Sorry my review missed this.

Acked-by: William Irwin <wli@holomorphy.com>


-- wli
