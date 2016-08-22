From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] CodingStyle: add some more error handling guidelines
Date: Mon, 22 Aug 2016 21:50:06 +0300
Message-ID: <20160822185006.GF4129@mwanda>
References: <1471874251-7721-1-git-send-email-mst@redhat.com>
	<20160822081617.386db8cd@lwn.net>
	<20160822174355-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20160822174355-mutt-send-email-mst@kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Julia Lawall <julia.lawall@lip6.fr>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Aug 22, 2016 at 05:53:02PM +0300, Michael S. Tsirkin wrote:
> The point is really naming label for the part of init that failed
> (and so needs to be skipped), rather than the part that will run.

Naming labels after what "needs to be skipped" doesn't work.  How does
that meaning make sense for err_cgroup in vhost_dev_set_owner()?  What
needs to be skipped here?

regards,
dan carpenter
