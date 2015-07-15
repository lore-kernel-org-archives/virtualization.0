From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [patch] vhost: NULL vs ERR_PTR bug
Date: Wed, 15 Jul 2015 14:41:06 +0300
Message-ID: <20150715114106.GD5784@mwanda>
References: <20150715111659.GA22854@mwanda>
	<20150715142420-mutt-send-email-mst@redhat.com>
	<55A64574.1090907@bfs.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <55A64574.1090907@bfs.de>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: walter harms <wharms@bfs.de>
Cc: Igor Mammedov <imammedo@redhat.com>, virtualization@lists.linux-foundation.org, kernel-janitors@vger.kernel.org, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Jul 15, 2015 at 01:35:16PM +0200, walter harms wrote:
> Is this function needed at all ?
> 

It tries to kmalloc() memory and if it can't then it tries to vmalloc()
it.  There are a bunch of these functions.  Eventually someone should
put one in a common header.

regards,
dan carpenter
