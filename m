From: Andres Lagar-Cavilla <andreslc@gridcentric.ca>
Subject: Re: [patch 2/3] xen/privcmd: return -EFAULT on error
Date: Sun, 9 Sep 2012 15:49:29 -0400
Message-ID: <CBDACA0A-1E68-4FFE-860B-2801019E03E2__15153.7156700671$1347316622$gmane$org@gridcentric.ca>
References: <20120908095735.GB608@elgon.mountain>
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20120908095735.GB608@elgon.mountain>
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
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, xen-devel@lists.xensource.com, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Andres Lagar-Cavilla <andreslc@gridcentric.ca>, kernel-janitors@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org


On Sep 8, 2012, at 5:57 AM, Dan Carpenter wrote:

> __copy_to_user() returns the number of bytes remaining to be copied but
> we want to return a negative error code here.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Acked-by: Andres Lagar-Cavilla <andres@lagarcavilla.org>
> 
> diff --git a/drivers/xen/privcmd.c b/drivers/xen/privcmd.c
> index fdff8f9..0ce006a 100644
> --- a/drivers/xen/privcmd.c
> +++ b/drivers/xen/privcmd.c
> @@ -393,8 +393,11 @@ static long privcmd_ioctl_mmap_batch(void __user *udata, int version)
> 		state.err      = err_array;
> 		ret = traverse_pages(m.num, sizeof(xen_pfn_t),
> 				     &pagelist, mmap_return_errors_v1, &state);
> -	} else if (version == 2)
> +	} else if (version == 2) {
> 		ret = __copy_to_user(m.err, err_array, m.num * sizeof(int));
> +		if (ret)
> +			ret = -EFAULT;
> +	}
> 
> 	/* If we have not had any EFAULT-like global errors then set the global
> 	 * error to -ENOENT if necessary. */
