From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH RFC v4 07/17] virtio_config: endian conversion for v1.0
Date: Fri, 24 Oct 2014 16:52:35 +0300
Message-ID: <20141024135235.GB6024@redhat.com>
References: <1414081380-14623-1-git-send-email-mst@redhat.com>
	<1414081380-14623-8-git-send-email-mst@redhat.com>
	<20141024105327.11377ea5.cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20141024105327.11377ea5.cornelia.huck@de.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: David Hildenbrand <dahi@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Oct 24, 2014 at 10:53:27AM +0200, Cornelia Huck wrote:
> On Thu, 23 Oct 2014 19:24:30 +0300
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > We (ab)use virtio conversion functions for device-specific
> > config space accesses.
> > 
> > Reviewed-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
> > Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
> > Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >  include/linux/virtio_config.h | 9 ++++++---
> >  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> Not objecting to the patch, but something seems to have gotten messed
> up wrt authorship? You only adapted it, right?

I'll change author to Rusty.
