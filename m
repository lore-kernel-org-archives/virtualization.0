From: fluxion <flukshun@gmail.com>
Subject: Re: Strange finding about kernel samepage merging
Date: Mon, 6 Feb 2012 23:46:41 -0600
Message-ID: <CANAOKxsFYCW7EzrbNn4jc3wOq6dmDE-pnpn0khxvb4C0iP3DtA__117.807559627359$1328738757$gmane$org@mail.gmail.com>
References: <CAG4AFWaXVEHP+YikRSyt8ky9XsiBnwQ3O94Bgc7-b7nYL_2PZQ@mail.gmail.com>
	<CANAOKxs8j2T2b0tKssFX9NeC1wyMqjLMQmgmRwMs9qvokYcW2w@mail.gmail.com>
	<CAG4AFWZGr8SQF0rV+iys04HWmQ5WEGvXNcSZ9qJ7Jj9+FRbjCg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2008672798682274688=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CAG4AFWZGr8SQF0rV+iys04HWmQ5WEGvXNcSZ9qJ7Jj9+FRbjCg@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jidong Xiao <jidong.xiao@gmail.com>
Cc: linux-mm@kvack.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

--===============2008672798682274688==
Content-Type: multipart/alternative; boundary=e0cb4efe2888adb99304b8594dc0

--e0cb4efe2888adb99304b8594dc0
Content-Type: text/plain; charset=ISO-8859-1

On Feb 6, 2012 10:14 PM, "Jidong Xiao" <jidong.xiao@gmail.com> wrote:
>
> On Mon, Feb 6, 2012 at 10:35 PM, Michael Roth <mdroth@linux.vnet.ibm.com>
wrote:
> > My guess is you end up with 2 copies of each page on the guest: the
copy in
> > the guest's page cache, and the copy in the buffer you allocated. From
the
> > perspective of the host this all looks like anonymous memory, so ksm
merges
> > the pages.
>
> Yes, the result definitely shows that there two copies. But I don't
> understand why there would be two copies. So whenever you allocate
> memory in a guest OS, you will always create two copies of the same
> memory?

Well, not just guests, hosts as well. Most operating systems will, by
default, cache the data read from disks in memory to speed up subsequent
access. In your case you're also creating a copy by allocating a second
buffer and storing the data there as well.

Ksm only merges anonymous pages, not disk/page cache, but since your
guest's pagecache looks like anonymous memory to the host, ksm is able to
merge the dupes.

>
> An interesting thing is, if I replace the posix_memalign() function
> with the malloc() function (See the original program, the commented
> line.) there would be only one copy, i.e., no merging happens,
> however, since I need to have some page-aligned memory, that's why I
> use posix_memalign().

Yup, ksm can only detect duplicate pages, so if your buffer isn't page
aligned it's unable to merge with the copy in the guest's page cache

>
> Regards
> Jidong
>

--e0cb4efe2888adb99304b8594dc0
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<p><br>
On Feb 6, 2012 10:14 PM, &quot;Jidong Xiao&quot; &lt;<a href=3D"mailto:jido=
ng.xiao@gmail.com">jidong.xiao@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt; On Mon, Feb 6, 2012 at 10:35 PM, Michael Roth &lt;<a href=3D"mailto:md=
roth@linux.vnet.ibm.com">mdroth@linux.vnet.ibm.com</a>&gt; wrote:<br>
&gt; &gt; My guess is you end up with 2 copies of each page on the guest: t=
he copy in<br>
&gt; &gt; the guest&#39;s page cache, and the copy in the buffer you alloca=
ted. From the<br>
&gt; &gt; perspective of the host this all looks like anonymous memory, so =
ksm merges<br>
&gt; &gt; the pages.<br>
&gt;<br>
&gt; Yes, the result definitely shows that there two copies. But I don&#39;=
t<br>
&gt; understand why there would be two copies. So whenever you allocate<br>
&gt; memory in a guest OS, you will always create two copies of the same<br=
>
&gt; memory?</p>
<p>Well, not just guests, hosts as well. Most operating systems will, by de=
fault, cache the data read from disks in memory to speed up subsequent acce=
ss. In your case you&#39;re also creating a copy by allocating a second buf=
fer and storing the data there as well.</p>

<p>Ksm only merges anonymous pages, not disk/page cache, but since your gue=
st&#39;s pagecache looks like anonymous memory to the host, ksm is able to =
merge the dupes.</p>
<p>&gt;<br>
&gt; An interesting thing is, if I replace the posix_memalign() function<br=
>
&gt; with the malloc() function (See the original program, the commented<br=
>
&gt; line.) there would be only one copy, i.e., no merging happens,<br>
&gt; however, since I need to have some page-aligned memory, that&#39;s why=
 I<br>
&gt; use posix_memalign().</p>
<p>Yup, ksm can only detect duplicate pages, so if your buffer isn&#39;t pa=
ge aligned it&#39;s unable to merge with the copy in the guest&#39;s page c=
ache</p>
<p>&gt;<br>
&gt; Regards<br>
&gt; Jidong<br>
&gt;<br>
</p>

--e0cb4efe2888adb99304b8594dc0--

--===============2008672798682274688==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============2008672798682274688==--
