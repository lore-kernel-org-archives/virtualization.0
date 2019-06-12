From: Pankaj Gupta <pagupta@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v12 4/7] dm: enable synchronous dax
Date: Tue, 11 Jun 2019 22:23:09 -0400 (EDT)
Message-ID: <332155967.34508010.1560306189624.JavaMail.zimbra__27884.1096254595$1560306333$gmane$org@redhat.com>
References: <20190611163802.25352-1-pagupta@redhat.com>
	<20190611163802.25352-5-pagupta@redhat.com>
	<20190611171416.GA1248@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190611171416.GA1248@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Mike Snitzer <snitzer@redhat.com>
Cc: rdunlap@infradead.org, jack@suse.cz, kvm@vger.kernel.org, mst@redhat.com, david@fromorbit.com, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, dm-devel@redhat.com, adilger kernel <adilger.kernel@dilger.ca>, zwisler@kernel.org, aarcange@redhat.com, dave jiang <dave.jiang@intel.com>, jstaron@google.com, linux-nvdimm@lists.01.org, vishal l verma <vishal.l.verma@intel.com>, willy@infradead.org, hch@infradead.org, linux-acpi@vger.kernel.org, jmoyer@redhat.com, linux-ext4@vger.kernel.org, lenb@kernel.org, kilobyte@angband.pl, riel@surriel.com, yuval shaia <yuval.shaia@oracle.com>, stefanha@redhat.com, imammedo@redhat.com, dan j williams <dan.j.williams@intel.com>, lcapitulino@redhat.com, nilal@redhat.com, tytso@mit.edu, xiaoguangrong eric <xiaoguangrong.eric@gmail.com>, cohuck@redhat.com, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-xfs@vger.kerne
List-Id: virtualization@lists.linuxfoundation.org


> On Tue, Jun 11 2019 at 12:37pm -0400,
> Pankaj Gupta <pagupta@redhat.com> wrote:
> 
> > This patch sets dax device 'DAXDEV_SYNC' flag if all the target
> > devices of device mapper support synchrononous DAX. If device
> > mapper consists of both synchronous and asynchronous dax devices,
> > we don't set 'DAXDEV_SYNC' flag.
> > 
> > 'dm_table_supports_dax' is refactored to pass 'iterate_devices_fn'
> > as argument so that the callers can pass the appropriate functions.
> > 
> > Suggested-by: Mike Snitzer <snitzer@redhat.com>
> > Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
> 
> Thanks, and for the benefit of others, passing function pointers like
> this is perfectly fine IMHO because this code is _not_ in the fast
> path.  These methods are only for device creation.
> 
> Reviewed-by: Mike Snitzer <snitzer@redhat.com>

Thank you, Mike

Best regards,
Pankaj

> 
> 
