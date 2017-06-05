From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH] virtio_net: lower limit on buffer size
Date: Mon, 5 Jun 2017 15:36:17 -0400
Message-ID: <20170605193617.GA1936__47503.1182555996$1497319677$gmane$org@fieldses.org>
References: <1496361148-4603-1-git-send-email-mst@redhat.com>
	<3dd90d56-7110-bb9e-0b7f-4c8a8003a57f@cogentembedded.com>
	<20170602202536.GA24411@fieldses.org>
	<aafb81af-54f2-06b0-3b5c-2713bc28184b@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <aafb81af-54f2-06b0-3b5c-2713bc28184b@cogentembedded.com>
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

On Sat, Jun 03, 2017 at 11:17:30PM +0300, Sergei Shtylyov wrote:
> On 06/02/2017 11:25 PM, J. Bruce Fields wrote:
> 
> >>>commit d85b758f72b0 "virtio_net: fix support for small rings"
> >>
> >>   Commit d85b758f72b0 ("virtio_net: fix support for small rings")
> >>
> >>>was supposed to increase the buffer size for small rings
> >>>but had an unintentional side effect of decreasing
> >>>it for large rings. This seems to break some setups -
> >>>it's not yet clear why, but increasing buffer size
> >>>back to what it was before helps.
> >>>
> >>>Fixes: d85b758f72b0 "virtio_net: fix support for small rings"
> >>
> >>Fixes: d85b758f72b0 ("virtio_net: fix support for small rings")
> >
> >I may be bikeshedding, but, personally I never do the parens--they're
> >redundant given the quotes, and space is often tight.
> 
>    Just see Documetation/process/submitting-patches.rst.

Yeah, I know, I claim it's a bad rule (but I'm too lazy to send a patch,
so, weight my opinion accordingly).

--b.
