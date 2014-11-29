From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v6 01/46] virtio: add low-level APIs for feature bits
Date: Sat, 29 Nov 2014 19:32:26 +0200
Message-ID: <20141129173226.GG22746@redhat.com>
References: <1417118789-18231-1-git-send-email-mst@redhat.com>
	<1417118789-18231-2-git-send-email-mst@redhat.com>
	<20141128131057.6046a382@thinkpad-w530>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20141128131057.6046a382@thinkpad-w530>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: David Hildenbrand <dahi@linux.vnet.ibm.com>
Cc: thuth@linux.vnet.ibm.com, rusty@au1.ibm.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, pbonzini@redhat.com, David Miller <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Nov 28, 2014 at 01:10:57PM +0100, David Hildenbrand wrote:
> > Add low level APIs to test/set/clear feature bits.
> > For use by transports, to make it easier to
> > write code independent of feature bit array format.
> > 
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >  include/linux/virtio_config.h | 53 ++++++++++++++++++++++++++++++++++++++++---
> >  1 file changed, 50 insertions(+), 3 deletions(-)
> > 
> 
> As these functions really set feature bits, I would rather name them:
> 
> virtio_has_feature ...
> virtio_set_feature ...
> virtio_clear_feature ...

We have these as high level APIs for drivers.
These are low level ones so need a different
name.


> But in general, this looks good to me!
