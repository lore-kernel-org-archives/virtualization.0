From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [Xen-devel] [patch 1/3] xen/privcmd: check for integer overflow
	in	ioctl
Date: Mon, 10 Sep 2012 14:20:54 +0300
Message-ID: <20120910112053.GW19410@mwanda>
References: <20120908095208.GA608@elgon.mountain> <504DC25F.7000508@citrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <504DC25F.7000508@citrix.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: David Vrabel <david.vrabel@citrix.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, xen-devel@lists.xensource.com, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Andres Lagar-Cavilla <andreslc@gridcentric.ca>, kernel-janitors@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Sep 10, 2012 at 11:35:11AM +0100, David Vrabel wrote:
> On 08/09/12 10:52, Dan Carpenter wrote:
> > If m.num is too large then the "m.num * sizeof(*m.arr)" multiplication
> > could overflow and the access_ok() check wouldn't test the right size.
> 
> m.num is range checked later on so it doesn't matter that the
> access_ok() checks might be wrong.  A bit subtle, perhaps.
> 

Yeah.  It's too subtle for my static checker but not so subtle for
a human being.  Laziness on my part.

Please drop this patch.

regards,
dan carpenter
