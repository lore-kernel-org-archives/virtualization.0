From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH driver-core-linus] kernfs: kernfs_notify() must be
	useable from non-sleepable contexts
Date: Wed, 2 Jul 2014 10:14:16 -0400
Message-ID: <20140702141416.GA23275@htj.dyndns.org>
References: <CA+5PVA4h2hQJLrAm4eEZ8oUgGiAjq2y5eAyBcJWxK_FiQXnuQg@mail.gmail.com>
	<20140629082637.GA23942@redhat.com> <20140629193222.GA7030@lst.de>
	<20140629204710.GB11100@redhat.com> <53B07D48.60003@kernel.dk>
	<20140630201741.GA20853@htj.dyndns.org>
	<20140701204103.GA12459@htj.dyndns.org>
	<20140701205148.GA26542@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20140701205148.GA26542@kroah.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jens Axboe <axboe@kernel.dk>, Josh Boyer <jwboyer@fedoraproject.org>, "Michael S. Tsirkin" <mst@redhat.com>, John McCutchan <john@johnmccutchan.com>, "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, Robert Love <rlove@rlove.org>, Eric Paris <eparis@parisplace.org>, Brian Lane <bcl@redhat.com>, Christoph Hellwig <hch@lst.de>
List-Id: virtualization@lists.linuxfoundation.org

Hello,

On Tue, Jul 01, 2014 at 01:51:48PM -0700, Greg Kroah-Hartman wrote:
> Looks good to me, do you want to take this with your other kernfs
> patches for 3.16-final?  Or if you don't have that, I can take it
> through my tree, it's your choice, either is fine for me.
> 
> If you want it in your tree, feel free to add:
> 	Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

The other kernfs changes are cgroup specific and in
cgroup/for-3.16-fixes.  I think this one fits better in the driver
core tree.  Can you please route it?

Thanks!

-- 
tejun
