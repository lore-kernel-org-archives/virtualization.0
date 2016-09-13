From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: Re: virtio_blk: Less function calls in init_vq() after error detection
Date: Tue, 13 Sep 2016 16:33:03 +0200
Message-ID: <55fbd4d0-3fb3-0334-6545-cb4da0d12edf@users.sourceforge.net>
References: <566ABCD9.1060404@users.sourceforge.net>
	<02054675-8395-ac81-6863-e3a5cbfc9032@users.sourceforge.net>
	<f56845a8-03c6-d3f7-6091-99dba9835780@users.sourceforge.net>
	<e918e655-cd86-c3c8-d911-9dfc03b03e19@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <e918e655-cd86-c3c8-d911-9dfc03b03e19@de.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: =?UTF-8?Q?Christian_Borntr=c3=a4ger?= <borntraeger@de.ibm.com>, virtualization@lists.linux-foundation.org, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Julia Lawall <julia.lawall@lip6.fr>, kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Minfei Huang <mnghuan@gmail.com>, linux-doc@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

>>  drivers/block/virtio_blk.c | 22 +++++++++++++++++-----
>>  1 file changed, 17 insertions(+), 5 deletions(-)
> 
> Can't you see from this diffstat that the patch actually seems to makes
> the code more complex?

I find that the repeated usage of a bit more error handling code is almost
unavoidable if you would like to handle allocation failures more directly
as I dared to propose again here.


> In addition, please have a look at commit 347a529398e8e723338cca5d8a8ae2d9e7e93448
>     virtio_blk: Fix a slient kernel panic
> 
> which did the opposite of your patch.

This software update adjusted also the jump targets. This approach
triggered another update suggestion (in addition to improvements around
the function "kmalloc_array").

Such a software development shows different views on the implementation
for correct exception handling. I am not so "silent" on this development topic
for years.


> And in fact it fixed a bug.

I get the impression from Minfei's contribution that the statement "err = -ENOMEM;"
was added behind memory allocations.
It was also chosen to restructure this function implementation so that
the single label "out" was used there for a while.

* Is this detail worth for another look?

* How does this name selection fit to the current Linux coding style convention?


> Quite obviously multiple labels are harder to read

I do not agree agree completely to your opinion.


> and harder to get right.

These identifiers can generate their own kind of software development
challenges as usual.


> For error handling with just kfree one label is just the right thing to.

This approach can look convenient at first glance.
Does the correctness aspect need any further considerations?

Regards,
Markus
