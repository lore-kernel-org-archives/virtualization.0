From: tgh <wwwwww4187@sina.com.cn>
Subject: Re: Re: Next steps with pv_ops for Xen
Date: Tue, 04 Dec 2007 17:35:44 +0800
Message-ID: <47551F70.7080300@sina.com.cn>
References: <000001c835db$72d9de90$ddf4e880@pwfad.pwf.private.cam.ac.uk>
	<200712031908.11079.mark.williamson@cl.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <200712031908.11079.mark.williamson@cl.cam.ac.uk>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Mark Williamson <mark.williamson@cl.cam.ac.uk>
Cc: xen-devel@lists.xensource.com, 'Eduardo Habkost' <ehabkost@redhat.com>, 'Juan Quintela' <quintela@redhat.com>, "'Stephen C. Tweedie'" <sct@redhat.com>, 'Jan Beulich' <jbeulich@novell.com>, 'Glauber de Oliveira Costa' <gcosta@redhat.com>, 'Chris Wright' <chrisw@sous-sol.org>, virtualization@lists.osdl.org, dgm36@cam.ac.uk, 'Gerd Hoffmann' <kraxel@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

hi
I am not quite clear about the purpose of pv-ops , what do we want to=20
deal with by developping "pv-ops"? is it used for HVM or for PV or KVM=20
or something ? I have seen it for a few months in the list ,and=20
"pv-ops"is an active project ,but i am not clear about what is the aim=20
of "pv-ops" ,could you give me an explanation about it

Thanks in advance




Mark Williamson =E5=86=99=E9=81=93:
>> Hi Mark,
>>
>>    =20
>>> Maybe a change to the gntdev userspace API to allow batching
>>> of mapping requests?
>>>      =20
>> Something along the lines of the following?
>>    =20
>
> Just like that :-D
>
> When you said "multiple syscalls per mapping" I assumed you meant that =
we'd=20
> lose the batching you get by doing a mulicall.  If it's just a couple o=
f=20
> syscalls (plus, presumably a couple of hypercalls) per batch of mapping=
s, my=20
> gut says it's probably not going to hurt block performance.  My guts ha=
ve=20
> been wrong in (many!) ways before of course...
>
> I guess the overhead *could* be reduced even more by just having a magi=
c ioctl=20
> that did all the mmap-ing stuff in one operation, but that'd probably b=
e=20
> really gross if it wasn't necessary!  And I doubt it'd make upstream ve=
ry=20
> happy...
>
> We'll also be eliminating the overheads involved in having a blktap rin=
g for=20
> talking to userspace and having to move requests between that ring and =
the=20
> real block ring, so there's some definite wins in overheads as well.
>
> Cheers,
> Mark
>
>  =20
