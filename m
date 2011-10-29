From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH 1/1] Staging: hv: Move the mouse driver out of staging
Date: Sat, 29 Oct 2011 09:32:40 +0300
Message-ID: <20111029063240.GH14881@longonot.mountain>
References: <1319841316-29136-1-git-send-email-kys@microsoft.com>
	<alpine.LNX.2.00.1110290041500.31615@swampdragon.chaosbits.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1110290041500.31615@swampdragon.chaosbits.net>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/devel>
List-Post: <mailto:devel@linuxdriverproject.org>
List-Help: <mailto:devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: devel-bounces@linuxdriverproject.org
Sender: devel-bounces@linuxdriverproject.org
To: Jesper Juhl <jj@chaosbits.net>
Cc: gregkh@suse.de, jkosina@suse.cz, dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org, ohering@suse.com, virtualization@lists.osdl.org, joe@perches.com, devel@linuxdriverproject.org
List-Id: virtualization@lists.linuxfoundation.org

On Sat, Oct 29, 2011 at 12:54:34AM +0200, Jesper Juhl wrote:
> > +			default:
> > +				pr_err("unhandled packet type %d, tid %llx len %d\n",
> > +				   desc->type,
> > +				   req_id,
> > +				   bytes_recvd);
> 
> Why not:
> 
>                                 pr_err("unhandled packet type %d, tid %llx 
>                                        len %d\n", desc->type, req_id, bytes_recvd);

Because then the printk would be messed up?  Your final printed
string would look like:

"unhandled packet type %d, tid %llx 
                                       len %d\n"

Don't break strings up across lines because it breaks grep.  If K. Y.
wants to put all the parameters on one line instead of three that
would probably be better, but in the end who cares?

regards,
dan carpenter
