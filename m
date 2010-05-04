From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [Qemu-devel] Re: [PATCH] virtio-spec: document block CMD and
	FLUSH
Date: Tue, 4 May 2010 07:56:24 +0100
Message-ID: <z2mfbd9d3991005032356y78419665n17bf34b7f586ad75@mail.gmail.com>
References: <20100218222220.GA14847@redhat.com>
	<201005041408.25069.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2182005450167873986=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <201005041408.25069.rusty@rustcorp.com.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Mime-version: 1.0
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: tytso@mit.edu, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, Neil Brown <neilb@suse.de>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, Jens Axboe <jens.axboe@oracle.com>, hch@lst.de
List-Id: virtualization@lists.linuxfoundation.org

--===============2182005450167873986==
Content-Type: multipart/alternative; boundary=e0cb4e88769d384efd0485bf35f0

--e0cb4e88769d384efd0485bf35f0
Content-Type: text/plain; charset=ISO-8859-1

A userspace barrier API would be very useful instead of doing fsync when
only ordering is required. I'd like to follow that discussion too.

Stefan

On 4 May 2010 05:39, "Rusty Russell" <rusty@rustcorp.com.au> wrote:

On Fri, 19 Feb 2010 08:52:20 am Michael S. Tsirkin wrote:
> I took a stub at documenting CMD and FLU...
ISTR Christoph had withdrawn some patches in this area, and was waiting
for him to resubmit?

I've given up on figuring out the block device.  What seem to me to be sane
semantics along the lines of memory barriers are foreign to disk people:
they
want (and depend on) flushing everywhere.

For example, tdb transactions do not require a flush, they only require what
I would call a barrier: that prior data be written out before any future
data.
Surely that would be more efficient in general than a flush!  In fact, TDB
wants only writes to *that file* (and metadata) written out first; it has no
ordering issues with other I/O on the same device.

A generic I/O interface would allow you to specify "this request depends on
these
outstanding requests" and leave it at that.  It might have some sync flush
command for dumb applications and OSes.  The userspace API might be not be
as
precise and only allow such a barrier against all prior writes on this fd.

ISTR someone mentioning a desire for such an API years ago, so CC'ing the
usual I/O suspects...

Cheers,
Rusty.

--e0cb4e88769d384efd0485bf35f0
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<p>A userspace barrier API would be very useful instead of doing fsync when=
 only ordering is required. I&#39;d like to follow that discussion too.</p>
<p>Stefan</p>
<p><blockquote type=3D"cite">On 4 May 2010 05:39, &quot;Rusty Russell&quot;=
 &lt;<a href=3D"mailto:rusty@rustcorp.com.au">rusty@rustcorp.com.au</a>&gt;=
 wrote:<br><br><p><font color=3D"#500050">On Fri, 19 Feb 2010 08:52:20 am M=
ichael S. Tsirkin wrote:<br>
&gt; I took a stub at documenting CMD and FLU...</font></p>ISTR Christoph h=
ad withdrawn some patches in this area, and was waiting<br>
for him to resubmit?<br>
<br>
I&#39;ve given up on figuring out the block device. =A0What seem to me to b=
e sane<br>
semantics along the lines of memory barriers are foreign to disk people: th=
ey<br>
want (and depend on) flushing everywhere.<br>
<br>
For example, tdb transactions do not require a flush, they only require wha=
t<br>
I would call a barrier: that prior data be written out before any future da=
ta.<br>
Surely that would be more efficient in general than a flush! =A0In fact, TD=
B<br>
wants only writes to *that file* (and metadata) written out first; it has n=
o<br>
ordering issues with other I/O on the same device.<br>
<br>
A generic I/O interface would allow you to specify &quot;this request depen=
ds on these<br>
outstanding requests&quot; and leave it at that. =A0It might have some sync=
 flush<br>
command for dumb applications and OSes. =A0The userspace API might be not b=
e as<br>
precise and only allow such a barrier against all prior writes on this fd.<=
br>
<br>
ISTR someone mentioning a desire for such an API years ago, so CC&#39;ing t=
he<br>
usual I/O suspects...<br>
<br>
Cheers,<br>
<font color=3D"#888888">Rusty.<br>
<br>
<br>
</font></blockquote></p>

--e0cb4e88769d384efd0485bf35f0--

--===============2182005450167873986==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linux-foundation.org/mailman/listinfo/virtualization
--===============2182005450167873986==--
