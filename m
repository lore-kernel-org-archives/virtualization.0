From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH] qxl: Use struct_size() in kzalloc()
Date: Wed, 9 Jan 2019 09:32:02 +0100
Message-ID: <20190109083202.r4pxsuskcxdzpvzj__16097.1919111491$1547022601$gmane$org@sirius.home.kraxel.org>
References: <20190108162152.GA25361@embeddedor>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190108162152.GA25361@embeddedor>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, Daniel Vetter <daniel@ffwll.ch>, Dave Airlie <airlied@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Jan 08, 2019 at 10:21:52AM -0600, Gustavo A. R. Silva wrote:
> One of the more common cases of allocation size calculations is finding the
> size of a structure that has a zero-sized array at the end, along with memory
> for some number of elements for that array. For example:
> 
> struct foo {
>     int stuff;
>     void *entry[];
> };
> 
> instance = kzalloc(sizeof(struct foo) + sizeof(void *) * count, GFP_KERNEL);
> 
> Instead of leaving these open-coded and prone to type mistakes, we can now
> use the new struct_size() helper:
> 
> instance = kzalloc(struct_size(instance, entry, count), GFP_KERNEL);
> 
> This code was detected with the help of Coccinelle.

Patch queued up.

thanks,
  Gerd
