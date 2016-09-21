From: Amit Shah <amit.shah@redhat.com>
Subject: Re: [PATCH 02/11] virtio_console: Less function calls in init_vqs()
	after error detection
Date: Wed, 21 Sep 2016 17:40:38 +0530
Message-ID: <20160921121038.GE1375@amit-lp.rh>
References: <566ABCD9.1060404@users.sourceforge.net>
	<020438b9-a7f8-0050-04c1-43382ba60b75@users.sourceforge.net>
	<490b98e1-6129-f11f-55ff-94219ebce6d6@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <490b98e1-6129-f11f-55ff-94219ebce6d6@users.sourceforge.net>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: Arnd Bergmann <arnd@arndb.de>, "Michael S. Tsirkin" <mst@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, Julia Lawall <julia.lawall@lip6.fr>
List-Id: virtualization@lists.linuxfoundation.org

Hi,

On (Wed) 14 Sep 2016 [16:01:28], SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Wed, 14 Sep 2016 14:00:35 +0200
> 
> The kfree() function was called in up to five cases
> by the init_vqs() function during error handling even if
> the passed variable contained a null pointer.
> 
> * Return directly after a call of the function "kmalloc_array" failed
>   at the beginning.
> 
> * Split a condition check for memory allocation failures so that
>   each pointer from these function calls will be checked immediately.
> 
>   See also background information:
>   Topic "CWE-754: Improper check for unusual or exceptional conditions"
>   Link: https://cwe.mitre.org/data/definitions/754.html
> 
> * Adjust jump targets according to the Linux coding style convention.

So I've seen this series and I'm not yet sure how I feel about the
patches - f.e. in this one, it adds more lines than it removes to
achieve the same effect.  I think the code is currently more readable
than after these changes.  And even if kfree is called multiple times,
it isn't a huge bother -- it's error case anyway, very unlikely to
trigger, but keeps everything very readble.


		Amit
