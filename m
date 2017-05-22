From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: Re: vhost/scsi: Delete error messages for failed memory allocations
	in five functions
Date: Mon, 22 May 2017 13:34:34 +0200
Message-ID: <e6658e56-a2b0-4ecc-0a95-0ba193ff2c97__24359.9851419733$1495452891$gmane$org@users.sourceforge.net>
References: <bafa65e4-08fe-efdb-d836-7657e8a64749@users.sourceforge.net>
	<babc429d-6440-92aa-e1d0-eee2636a8d0f@users.sourceforge.net>
	<20170522094320.GE12205@stefanha-x1.localdomain>
	<557bdff4-6dc2-756d-0d59-9f688ef11f0a@users.sourceforge.net>
	<20170522112320.GA22806@stefanha-x1.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170522112320.GA22806@stefanha-x1.localdomain>
Content-Language: en-GB
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

>> Do you find information from a Linux allocation failure report sufficient
>> for any function implementations here?
> 
> If kmalloc() and friends guarantee to print a warning and backtrace on
> every allocation failure, then there's no need for error messages in
> callers.
> 
> That seems like good justification that can go in the commit
> description, but I'm not sure if kmalloc() and friends guarantee to show
> a message (not just the first time, but for every failed allocation)?

I am also looking for a more complete and easier accessible documentation
for this aspect of the desired exception handling.
How would we like to resolve any remaining open issues there?

Regards,
Markus
