From: Amit Shah <amit.shah@redhat.com>
Subject: Re: [patch] virtio: console: fix error handling for
	debugfs_create_dir()
Date: Fri, 19 Jul 2013 11:43:01 +0530
Message-ID: <20130719061301.GI3087@amit-x200.redhat.com>
References: <20130719055049.GD9729@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20130719055049.GD9729@elgon.mountain>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kernel-janitors@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On (Fri) 19 Jul 2013 [08:50:49], Dan Carpenter wrote:
> debugfs_create_dir() returns ERR_PTR(-ENODEV) if debugfs is disabled.
> Also my static checker doesn't like it when we print the error code, but
> it's always just NULL.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Reviewed-by: Amit Shah <amit.shah@redhat.com>

Today seems to be the 'fix virtio-console day'.

Thanks,
		Amit
