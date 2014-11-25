From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v4 07/42] virtio_config: endian conversion for v1.0
Date: Tue, 25 Nov 2014 23:36:14 +0200
Message-ID: <20141125213614.GB22343@redhat.com>
References: <1416933600-21398-1-git-send-email-mst@redhat.com>
	<1416933600-21398-8-git-send-email-mst@redhat.com>
	<20141125184557.1e171669.cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20141125184557.1e171669.cornelia.huck@de.ibm.com>
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
Cc: rusty@au1.ibm.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, David Hildenbrand <dahi@linux.vnet.ibm.com>, pbonzini@redhat.com, David Miller <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Nov 25, 2014 at 06:45:57PM +0100, Cornelia Huck wrote:
> On Tue, 25 Nov 2014 18:41:52 +0200
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > We (ab)use virtio conversion functions for device-specific
> > config space accesses.
> > 
> > Reviewed-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
> > Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
> > Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> 
> This looks odd with the various sign-offs but you as author...

Signoff tracks all contributors for developer's certificate
of origin purposes.

Looking at the patch itself, not a single line (except the subject) seems
to be shared with the original patch by Rusty that was posted with the
same subject, so I guess I could have dropped them here, but as I
refactor code I usually keep all signoffs around as a matter of policy.

Would you like yours to be dropped then?


> > ---
> >  include/linux/virtio_config.h | 9 ++++++---
> >  1 file changed, 6 insertions(+), 3 deletions(-)
