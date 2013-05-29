From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2 0/2] virtio-balloon spec: silent deflation
Date: Wed, 29 May 2013 17:21:28 +0300
Message-ID: <20130529142128.GA10462@redhat.com>
References: <1369762818-8787-1-git-send-email-pbonzini@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1369762818-8787-1-git-send-email-pbonzini@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, May 28, 2013 at 07:40:16PM +0200, Paolo Bonzini wrote:
> Here is the series, split in two patches, with small edits and new
> commit messages.
> 
> Paolo Bonzini (2):
>   virtio-balloon spec: rewrite description of
>     VIRTIO_BALLOON_F_MUST_TELL_HOST
>   virtio-balloon spec: reintroduce "silent deflation" feature
> 
>  virtio-spec.lyx | 238 ++++++++++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 233 insertions(+), 5 deletions(-)

Okay we talked off-line a bit, here's a summary:

- we both agree we want my patch making TELL_HOST optional,
  just to make current practice with windows drivers, legal.
  Will ask Rusty to re-consider it for inclusion.

- Paolo's patches need some experimentation, it's not 100%
  clear what the benefit is, and maybe it's possible to
  get same gains without spec/guest driver changes.


> -- 
> 1.8.2.1
