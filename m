From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCHv2] virtio: order used ring after used index read
Date: Mon, 26 Oct 2009 10:25:38 +1030
Message-ID: <200910261025.38950.rusty__19997.4219002344$1256514996$gmane$org@rustcorp.com.au>
References: <20091025132853.GA21301@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20091025132853.GA21301@redhat.com>
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
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Sun, 25 Oct 2009 11:58:53 pm Michael S. Tsirkin wrote:
> On SMP guests, reads from the ring might bypass
> used index reads. This causes guest crashes
> because host writes to used index to signal ring data
> readiness.
> Fix this by inserting rmb before used ring reads.

Thanks, good spotting.  Applied.

Rusty.
