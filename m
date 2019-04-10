From: Pankaj Gupta <pagupta@redhat.com>
Subject: Re: [PATCH v5 3/6] libnvdimm: add dax_dev sync flag
Date: Wed, 10 Apr 2019 04:38:33 -0400 (EDT)
Message-ID: <1336073020.20708683.1554885513376.JavaMail.zimbra__24293.4638912388$1554885547$gmane$org@redhat.com>
References: <20190410040826.24371-1-pagupta@redhat.com>
	<20190410040826.24371-4-pagupta@redhat.com>
	<20190410082804.GG1426@quack2.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190410082804.GG1426@quack2.suse.cz>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jan Kara <jack@suse.cz>
Cc: cohuck@redhat.com, kvm@vger.kernel.org, mst@redhat.com, david@fromorbit.com, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, adilger kernel <adilger.kernel@dilger.ca>, zwisler@kernel.org, aarcange@redhat.com, dave jiang <dave.jiang@intel.com>, linux-nvdimm@lists.01.org, vishal l verma <vishal.l.verma@intel.com>, willy@infradead.org, hch@infradead.org, linux-acpi@vger.kernel.org, jmoyer@redhat.com, linux-ext4@vger.kernel.org, lenb@kernel.org, kilobyte@angband.pl, riel@surriel.com, yuval shaia <yuval.shaia@oracle.com>, stefanha@redhat.com, pbonzini@redhat.com, dan j williams <dan.j.williams@intel.com>, lcapitulino@redhat.com, nilal@redhat.com, tytso@mit.edu, xiaoguangrong eric <xiaoguangrong.eric@gmail.com>, darrick wong <darrick.wong@oracle.com>, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org


> 
> On Wed 10-04-19 09:38:23, Pankaj Gupta wrote:
> > @@ -64,6 +65,10 @@ static inline bool dax_write_cache_enabled(struct
> > dax_device *dax_dev)
> >  {
> >  	return false;
> >  }
> > +static inline bool dax_synchronous(struct dax_device *dax_dev)
> > +{
> > +	return true;
> > +}
> 
> Is there a need to define dax_synchronous() for !CONFIG_DAX? Because that
> property of dax device is pretty much undefined and I don't see anything
> needing to call it for !CONFIG_DAX...

You are right. Will remove this.

Thanks for the review.

Best regards,
Pankaj

> 
> 								Honza
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
> 
