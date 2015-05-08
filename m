From: Amit Shah <amit.shah@redhat.com>
Subject: Re: [patch v2] virtio_console: silence a static checker warning
Date: Fri, 8 May 2015 14:59:47 +0530
Message-ID: <20150508092947.GA5527@grmbl.mre>
References: <20150508063118.GA6361@grmbl.mre> <20150508091624.GS14154@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20150508091624.GS14154@mwanda>
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

On (Fri) 08 May 2015 [12:16:25], Dan Carpenter wrote:
> My static checker complains that this sprintf() can overflow but really
> it can't.  Just silence the warning by using snprintf().

Reviewed-by: Amit Shah <amit.shah@redhat.com>

Thanks!


		Amit
