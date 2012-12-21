From: Amit Shah <amit.shah@redhat.com>
Subject: Re: [PATCH] virtio_console: correct error message on failure of
	debugfs_create_dir
Date: Fri, 21 Dec 2012 13:29:09 +0530
Message-ID: <20121221075909.GA15739@amit.redhat.com>
References: <1356030701-16284-1-git-send-email-sasha.levin@oracle.com>
	<1356030701-16284-13-git-send-email-sasha.levin@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1356030701-16284-13-git-send-email-sasha.levin@oracle.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Sasha Levin <sasha.levin@oracle.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On (Thu) 20 Dec 2012 [14:11:21], Sasha Levin wrote:
> debugfs_create_dir() returns NULL if it fails, there's little point in
> calling PTR_ERR on it.
> 
> Signed-off-by: Sasha Levin <sasha.levin@oracle.com>
> ---
>  drivers/char/virtio_console.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
> index c594cb1..490b70e 100644
> --- a/drivers/char/virtio_console.c
> +++ b/drivers/char/virtio_console.c
> @@ -2212,10 +2212,9 @@ static int __init init(void)
>  	}
>  
>  	pdrvdata.debugfs_dir = debugfs_create_dir("virtio-ports", NULL);
> -	if (!pdrvdata.debugfs_dir) {
> -		pr_warning("Error %ld creating debugfs dir for virtio-ports\n",
> -			   PTR_ERR(pdrvdata.debugfs_dir));
> -	}
> +	if (!pdrvdata.debugfs_dir)
> +		pr_warn("Error creating debugfs dir for virtio-ports\n");

debugfs_create_dir() does return an error value if debugfs is not
enabled.

This check for !pdrvdata.debugfs_dir should infact use
IS_ERR_OR_NULL().  Care to submit a patch for that?

		Amit
