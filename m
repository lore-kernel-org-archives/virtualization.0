From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] tools/virtio: Fix build
Date: Sun, 13 Oct 2019 09:39:04 -0400
Message-ID: <20191013093844-mutt-send-email-mst__24696.707462293$1570974549$gmane$org@kernel.org>
References: <4b686914-075b-a0a9-c97b-9def82ee0336@web.de>
	<20191013075107-mutt-send-email-mst@kernel.org>
	<08c1e081-765b-7c3a-ed31-2059dc521fd0@web.de>
	<20191013081541-mutt-send-email-mst@kernel.org>
	<eacb6818-fe3e-f983-9946-e172f0077d4b@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <eacb6818-fe3e-f983-9946-e172f0077d4b@web.de>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jan Kiszka <jan.kiszka@web.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Sun, Oct 13, 2019 at 03:29:34PM +0200, Jan Kiszka wrote:
> On 13.10.19 14:20, Michael S. Tsirkin wrote:
> > On Sun, Oct 13, 2019 at 02:01:03PM +0200, Jan Kiszka wrote:
> >> On 13.10.19 13:52, Michael S. Tsirkin wrote:
> >>> On Sun, Oct 13, 2019 at 11:03:30AM +0200, Jan Kiszka wrote:
> >>>> From: Jan Kiszka <jan.kiszka@siemens.com>
> >>>>
> >>>> Various changes in the recent kernel versions broke the build due to
> >>>> missing function and header stubs.
> >>>>
> >>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> >>>
> >>> Thanks!
> >>> I think it's already fixes in the vhost tree.
> >>> That tree also includes a bugfix for the test.
> >>> Can you pls give it a spin and report?
> >>
> >> Mostly fixed: the xen_domain stup is missing.
> >>
> >> Jan
> >
> > That's in xen/xen.h. Do you still see any build errors?
> 
> ca16cf7b30ca79eeca4d612af121e664ee7d8737 lacks this - forgot to add to
> some commit?
> 
> Jan

Oh, you are right.
Should be fixed now.
Thanks!
-- 
MST
