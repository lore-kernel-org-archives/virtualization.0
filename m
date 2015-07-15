From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [patch] vhost: NULL vs ERR_PTR bug
Date: Wed, 15 Jul 2015 17:40:43 +0300
Message-ID: <20150715144042.GF5835@mwanda>
References: <20150715111659.GA22854@mwanda>
	<20150715142420-mutt-send-email-mst@redhat.com>
	<55A64574.1090907@bfs.de>
	<alpine.DEB.2.10.1507151020460.2919@hadrien>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.10.1507151020460.2919@hadrien>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Julia Lawall <julia.lawall@lip6.fr>
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, kernel-janitors@vger.kernel.org, virtualization@lists.linux-foundation.org, Igor Mammedov <imammedo@redhat.com>, walter harms <wharms@bfs.de>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Jul 15, 2015 at 10:21:12AM -0400, Julia Lawall wrote:
> At least it looks like one could return the result of vzalloc directly?
> 
> julia

That's a true...  I was tempted to re-write it a bit.  I think one of
the Lustre people are eventually going to export this function and we
will delete this one.

regards,
dan carpenter
