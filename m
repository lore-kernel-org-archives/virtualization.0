From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCHv2 2/2] virtio: fix memory leak on device removal
Date: Fri, 24 Jul 2009 21:55:16 +0930
Message-ID: <200907242155.16735.rusty__14901.5527721078$1248438692$gmane$org@rustcorp.com.au>
References: <cover.1248350116.git.mst@redhat.com>
	<20090723115737.GC12293@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20090723115737.GC12293@redhat.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Carsten Otte <cotte@de.ibm.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>, avi@redhat.com, Anthony Liguori <anthony@codemonkey.ws>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 23 Jul 2009 09:27:37 pm Michael S. Tsirkin wrote:
> Make vp_free_vectors do the reverse of vq_request_vectors.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Thanks, applied!

Rusty.
