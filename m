From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PULL] vhost: cleanups and fixes
Date: Thu, 1 Nov 2018 16:06:19 -0700
Message-ID: <CAHk-=wicvws38JqzVF6oNEZ0jGzP6RecR6yAGtyzX3AkoJ321g__33162.7945685343$1541113845$gmane$org@mail.gmail.com>
References: <20181101171938-mutt-send-email-mst@kernel.org>
	<CAGXu5jJ0HgV2qN=wohEgro6ixqXHOHBTsvS5a9Dcpz8gxVo3bA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CAGXu5jJ0HgV2qN=wohEgro6ixqXHOHBTsvS5a9Dcpz8gxVo3bA@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Kees Cook <keescook@chromium.org>
Cc: lenaic@lhuard.fr, mhocko@suse.com, bijan.mottahedeh@oracle.com, kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org, liang.z.li@intel.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, stefanha@redhat.com, joe@perches.com, Andrew Morton <akpm@linux-foundation.org>, mhocko@kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Nov 1, 2018 at 4:00 PM Kees Cook <keescook@chromium.org> wrote:
>
> +       memset(&rsp, 0, sizeof(rsp));
> +       rsp.response = VIRTIO_SCSI_S_FUNCTION_REJECTED;
> +       resp = vq->iov[out].iov_base;
> +       ret = __copy_to_user(resp, &rsp, sizeof(rsp));
>
> Is it actually safe to trust that iov_base has passed an earlier
> access_ok() check here? Why not just use copy_to_user() instead?

Good point.

We really should have removed those double-underscore things ages ago.

Also, apart from the address, what about the size? Wouldn't it be
better to use copy_to_iter() rather than implement it badly by hand?

               Linus
