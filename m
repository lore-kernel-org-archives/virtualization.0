From: Alexander Graf <graf-vV1OtcyAfmbQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC]: mm,power: introduce MADV_WIPEONSUSPEND
Date: Mon, 6 Jul 2020 14:26:44 +0200
Message-ID: <57ab4fb3-3f82-d34f-ad74-2214b45a4dd9@amazon.com>
References: <B7793B7A-3660-4769-9B9A-FFCF250728BB@amazon.com>
 <20200703224411.GC25072@amd>
 <CAG48ez0oWQd42a-H-Dzw1Wq7HgB5PpFRGCZeYxP8ohxaoZHmvQ@mail.gmail.com>
 <20200704114820.GA16083@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-api-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200704114820.GA16083@amd>
Content-Language: en-US
Sender: linux-api-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Jann Horn <jannh-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Cc: "Catangiu, Adrian Costin" <acatan-vV1OtcyAfmbQT0dZR+AlfA@public.gmane.org>, "linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org" <linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "virtualization-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <virtualization-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-api-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-api-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org" <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, "rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, "len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "mhocko-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <mhocko-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "fweimer-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <fweimer-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "keescook-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org" <keescook-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, "luto-kltTT9wpgjJwATOyAt5JVQ@public.gmane.org" <luto-kltTT9wpgjJwATOyAt5JVQ@public.gmane.org>, "wad-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org" <wad-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, "mingo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <mingo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "bonzini-mXXj517/zsQ@public.gmane.org" <bonzini-mXXj517/zsQ@public.gmane.org>, "MacCarthaigh, Colm" <colmmacc-vV1OtcyAfmZhl2p70BpVqQ@public.gmane.org>
List-Id: virtualization@lists.linuxfoundation.org



On 04.07.20 13:48, Pavel Machek wrote:
> Hi!
> =

>>>> Cryptographic libraries carry pseudo random number generators to
>>>> quickly provide randomness when needed. If such a random pool gets
>>>> cloned, secrets may get revealed, as the same random number may get
>>>> used multiple times. For fork, this was fixed using the WIPEONFORK
>>>> madvise flag [1].
>>>
>>>> Unfortunately, the same problem surfaces when a virtual machine gets
>>>> cloned. The existing flag does not help there. This patch introduces a
>>>> new flag to automatically clear memory contents on VM suspend/resume,
>>>> which will allow random number generators to reseed when virtual
>>>> machines get cloned.
>>>
>>> Umm. If this is real problem, should kernel provide such rng in the
>>> vsdo page using vsyscalls? Kernel can have special interface to its
>>> vsyscalls, but we may not want to offer this functionality to rest of
>>> userland...
>>
>> And then the kernel would just need to maintain a sequence
>> number in the vDSO data page that gets bumped on suspen
> =

> Yes, something like that would work. Plus, we'd be free to change the
> mechanism in future.

So if we keep treading along that train of thought, a simple vsyscall =

that returns an epoch (incremented by every [VM] resume) would be good =

enough, as user space could in its own logic determine whether it's =

still living inside the same epoch.

The beauty of the clearing is that the checks on it are almost free and =

that we can avoid to store secrets on disk in the first place.

The latter I think is impossible to model with the epoch, but that might =

be ok.

Performance wise, I don't think we can make the vsyscall as cheap as a =

memory compare. Keep in mind that we need to check for the epoch in a =

pretty hot path. How bad would it really be? I'm not sure. It might be =

good enough.

My main concern however is around fragmentation of mechanisms. We =

already have the WIPEONFORK semantic in place in user space =

applications. Do we really want to introduce yet another check for =

what's almost the same semantic? With WIPEONSUSPEND, the hot path check =

between fork and suspend are identical. With an epoch, we have to check =

for zeros and the epoch in addition.

Unless we create a vsyscall that returns both the PID as well as the =

epoch and thus handles fork *and* suspend. I need to think about this a =

bit more :).


Alex



Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879
