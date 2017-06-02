From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH] virtio_net: lower limit on buffer size
Date: Fri, 2 Jun 2017 16:25:36 -0400
Message-ID: <20170602202536.GA24411__128.074774011289$1497319666$gmane$org@fieldses.org>
References: <1496361148-4603-1-git-send-email-mst@redhat.com>
	<3dd90d56-7110-bb9e-0b7f-4c8a8003a57f@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <3dd90d56-7110-bb9e-0b7f-4c8a8003a57f@cogentembedded.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Mikulas Patocka <mpatocka@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Jun 02, 2017 at 12:34:57PM +0300, Sergei Shtylyov wrote:
> Hello!
> 
> On 6/2/2017 2:56 AM, Michael S. Tsirkin wrote:
> 
> >commit d85b758f72b0 "virtio_net: fix support for small rings"
> 
>    Commit d85b758f72b0 ("virtio_net: fix support for small rings")
> 
> >was supposed to increase the buffer size for small rings
> >but had an unintentional side effect of decreasing
> >it for large rings. This seems to break some setups -
> >it's not yet clear why, but increasing buffer size
> >back to what it was before helps.
> >
> >Fixes: d85b758f72b0 "virtio_net: fix support for small rings"
> 
> Fixes: d85b758f72b0 ("virtio_net: fix support for small rings")

I may be bikeshedding, but, personally I never do the parens--they're
redundant given the quotes, and space is often tight.

--b.

> 
> >Reported-by: Mikulas Patocka <mpatocka@redhat.com>
> >Reported-by: "J. Bruce Fields" <bfields@fieldses.org>
> >Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> [...]
> 
> MBR, Sergei
