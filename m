From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] virtio_console: Add support for multiple ports for
	generic guest and host communication
Date: Thu, 17 Sep 2009 16:57:01 +0100
Message-ID: <20090917165701.400ad28c__10931.053318973$1253203112$gmane$org@lxorguk.ukuu.org.uk>
References: <1252678386-17404-2-git-send-email-amit.shah@redhat.com>
	<20090911170010.34c80f2d@linux.intel.com>
	<20090911163806.GB25535@amit-x200.redhat.com>
	<4AAA8838.1080106@codemonkey.ws>
	<20090911173307.GB27046@amit-x200.redhat.com>
	<4AAA8A56.3040707@codemonkey.ws>
	<20090916112332.6bf981a5@linux.intel.com>
	<4AB164A0.8000402@codemonkey.ws> <87tyz1en5f.fsf@pike.pond.sub.org>
	<20090917141531.4d2489d4@lxorguk.ukuu.org.uk>
	<20090917134125.GA27511@amit-x200.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20090917134125.GA27511@amit-x200.redhat.com>
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
Cc: greg@kroah.com, virtualization@lists.linux-foundation.org, Anthony Liguori <anthony@codemonkey.ws>, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

> Alan, I'm not sure how many ports at a time people would want to use so
> allocating one major device for this seems OK?

We have very large minor number ranges now so one dynamic major should do
you for a while yet. Probably forever but thats always asking for a
"640K.." moment ;)


> +static ssize_t fill_readbuf(struct virtio_console_port *port,
> +			    char *out_buf, size_t out_count, bool to_user)
> +{

Save yourself serious grief - and the FIXME pain noted below - unless you
are shipping huge objects use a bounce buffer and kill off the to_user
stuff - modern CPUs are so fast doing cache transfers it really isn't
worth the suffering for small stuff.

> +			ret = copy_to_user(out_buf + out_offset,
> +					   buf->buf + buf->offset,
> +					   copy_size);
> +			/* FIXME: Deal with ret != 0 */
