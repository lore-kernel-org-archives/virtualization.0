From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PULL] vhost: cleanups and fixes
Date: Fri, 30 Nov 2018 14:55:38 -0500
Message-ID: <20181130145527-mutt-send-email-mst__33689.0029757798$1543607625$gmane$org@kernel.org>
References: <20181101171938-mutt-send-email-mst@kernel.org>
	<CAGXu5jJ0HgV2qN=wohEgro6ixqXHOHBTsvS5a9Dcpz8gxVo3bA@mail.gmail.com>
	<CAHk-=wicvws38JqzVF6oNEZ0jGzP6RecR6yAGtyzX3AkoJ321g@mail.gmail.com>
	<20181130084227-mutt-send-email-mst@kernel.org>
	<e5eb0188-61fa-7556-4c36-68a618ba39bf@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <e5eb0188-61fa-7556-4c36-68a618ba39bf@oracle.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Bijan Mottahedeh <bijan.mottahedeh@oracle.com>
Cc: lenaic@lhuard.fr, mhocko@suse.com, Kees Cook <keescook@chromium.org>, kvm@vger.kernel.org, netdev@vger.kernel.org, liang.z.li@intel.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, stefanha@redhat.com, joe@perches.com, Andrew Morton <akpm@linux-foundation.org>, mhocko@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Nov 30, 2018 at 11:01:03AM -0800, Bijan Mottahedeh wrote:
> On 11/30/2018 5:44 AM, Michael S. Tsirkin wrote:
> > On Thu, Nov 01, 2018 at 04:06:19PM -0700, Linus Torvalds wrote:
> > > On Thu, Nov 1, 2018 at 4:00 PM Kees Cook <keescook@chromium.org> wrot=
e:
> > > > +       memset(&rsp, 0, sizeof(rsp));
> > > > +       rsp.response =3D VIRTIO_SCSI_S_FUNCTION_REJECTED;
> > > > +       resp =3D vq->iov[out].iov_base;
> > > > +       ret =3D __copy_to_user(resp, &rsp, sizeof(rsp));
> > > > =

> > > > Is it actually safe to trust that iov_base has passed an earlier
> > > > access_ok() check here? Why not just use copy_to_user() instead?
> > > Good point.
> > > =

> > > We really should have removed those double-underscore things ages ago.
> > > =

> > > Also, apart from the address, what about the size? Wouldn't it be
> > > better to use copy_to_iter() rather than implement it badly by hand?
> > > =

> > >                 Linus
> > Bijan can you respond please?
> > Are you going to look into this and convert code to copy_to_iter?
> > I don't think we should release Linux like this, so if you don't
> > have the time I'd rather revert for now and you can look
> > into reposting for the next release.
> > =

> > Thanks,
> > =

> =

> Sure, will do.=A0 Can I send an individual patch for the fix to
> vhost_scsi_send_tmf_reject()?
> =

> Thanks.
> =

> --bijan

Please go ahead.

-- =

MST
