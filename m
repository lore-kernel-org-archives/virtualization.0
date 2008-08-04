From: Dave Hansen <dave@linux.vnet.ibm.com>
Subject: Too many I/O controller patches
Date: Mon, 04 Aug 2008 10:20:33 -0700
Message-ID: <1217870433.20260.101.camel__43376.5768226751$1217870633$gmane$org@nimitz>
References: <20080804.175126.193692178.ryov@valinux.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20080804.175126.193692178.ryov@valinux.co.jp>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Ryo Tsuruta <ryov@valinux.co.jp>
Cc: xen-devel@lists.xensource.com, containers@lists.linux-foundation.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, dm-devel@redhat.com, agk@sourceware.org, Andrea Righi <righi.andrea@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 2008-08-04 at 17:51 +0900, Ryo Tsuruta wrote:
> This series of patches of dm-ioband now includes "The bio tracking mechanism,"
> which has been posted individually to this mailing list.
> This makes it easy for anybody to control the I/O bandwidth even when
> the I/O is one of delayed-write requests.

During the Containers mini-summit at OLS, it was mentioned that there
are at least *FOUR* of these I/O controllers floating around.  Have you
talked to the other authors?  (I've cc'd at least one of them).

We obviously can't come to any kind of real consensus with people just
tossing the same patches back and forth.

-- Dave
