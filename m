From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCHv4 2/2] virtio: refactor find_vqs
Date: Tue, 28 Jul 2009 17:58:02 +0300
Message-ID: <20090728145801.GA6048__1382.86559745229$1248793667$gmane$org@redhat.com>
References: <cover.1248623150.git.mst@redhat.com>
	<20090726154709.GC21829@redhat.com>
	<200907281244.32124.rusty@rustcorp.com.au>
	<20090728143052.GA10365@amit-x200.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20090728143052.GA10365@amit-x200.redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Amit Shah <amit.shah@redhat.com>
Cc: Carsten Otte <cotte@de.ibm.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>, avi@redhat.com, Anthony Liguori <anthony@codemonkey.ws>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Jul 28, 2009 at 08:00:52PM +0530, Amit Shah wrote:
> On (Tue) Jul 28 2009 [12:44:31], Rusty Russell wrote:
> > On Mon, 27 Jul 2009 01:17:09 am Michael S. Tsirkin wrote:
> > > This refactors find_vqs, making it more readable and robust, and fixing
> > > two regressions from 2.6.30:
> > > - double free_irq causing BUG_ON on device removal
> > > - probe failure when vq can't be assigned to msi-x vector
> > >   (reported on old host kernels)
> > > 
> > > An older version of this patch was tested by Amit Shah.
> > 
> > OK, I've applied both of these; I'd like to see a new test by Amit to
> > make sure tho.
> 
> Tested these patches as well. They work fine.
> 
> Tested-by: Amit Shah <amit.shah@redhat.com>

Amit, thanks very much for the testing.

-- 
MST
