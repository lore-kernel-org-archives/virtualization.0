From: Alexander Graf <graf-vV1OtcyAfmbQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC]: mm,power: introduce MADV_WIPEONSUSPEND
Date: Tue, 7 Jul 2020 10:01:23 +0200
Message-ID: <efa55313-ce8a-bac9-15df-167f93c672b3@amazon.com>
References: <B7793B7A-3660-4769-9B9A-FFCF250728BB@amazon.com>
 <20200703224411.GC25072@amd>
 <CAG48ez0oWQd42a-H-Dzw1Wq7HgB5PpFRGCZeYxP8ohxaoZHmvQ@mail.gmail.com>
 <20200704114820.GA16083@amd>
 <57ab4fb3-3f82-d34f-ad74-2214b45a4dd9@amazon.com>
 <CAG48ez1tAAD+x6n07uCisXpqVpDUPX7xBWiKFkS3u2azHqd41A@mail.gmail.com>
 <20200707074425.GC3820@dhcp22.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-api-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200707074425.GC3820-2MMpYkNvuYDjFM9bn6wA6Q@public.gmane.org>
Content-Language: en-US
Sender: linux-api-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michal Hocko <mhocko-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jann Horn <jannh-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Cc: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, "Catangiu, Adrian Costin" <acatan-vV1OtcyAfmbQT0dZR+AlfA@public.gmane.org>, "linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org" <linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "virtualization-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <virtualization-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-api-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-api-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org" <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, "rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, "len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "fweimer-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <fweimer-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "keescook-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org" <keescook-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, "luto-kltTT9wpgjJwATOyAt5JVQ@public.gmane.org" <luto-kltTT9wpgjJwATOyAt5JVQ@public.gmane.org>, "wad-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org" <wad-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, "mingo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <mingo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "bonzini-mXXj517/zsQ@public.gmane.org" <bonzini-mXXj517/zsQ@public.gmane.org>, "MacCarthaigh, Colm" <colmmacc-vV1OtcyAfmbQT0dZR+AlfA@public.gmane.org>
List-Id: virtualization@lists.linuxfoundation.org



On 07.07.20 09:44, Michal Hocko wrote:
> CAUTION: This email originated from outside of the organization. Do not c=
lick links or open attachments unless you can confirm the sender and know t=
he content is safe.
> =

> =

> =

> On Mon 06-07-20 14:52:07, Jann Horn wrote:
>> On Mon, Jul 6, 2020 at 2:27 PM Alexander Graf <graf-vV1OtcyAfmbQT0dZR+AlfA@public.gmane.org> wrote:
>>> Unless we create a vsyscall that returns both the PID as well as the
>>> epoch and thus handles fork *and* suspend. I need to think about this a
>>> bit more :).
>>
>> You can't reliably detect forking by checking the PID if it is
>> possible for multiple forks to be chained before the reuse check runs:
>>
>>   - pid 1000 remembers its PID
>>   - pid 1000 forks, creating child pid 1001
>>   - pid 1000 exits and is waited on by init
>>   - the pid allocator wraps around
>>   - pid 1001 forks, creating child pid 1000
>>   - child with pid 1000 tries to check for forking, determines that its
>> PID is 1000, and concludes that it is still the original process
> =

> I must be really missing something here because I really fail to see why
> there has to be something new even invented. Sure, checking for pid is
> certainly a suboptimal solution because pids are terrible tokens to work
> with. We do have a concept of file descriptors which a much better and
> supports signaling. There is a clear source of the signal IIUC
> (migration) and there are consumers to act upon that (e.g. crypto
> backends). So what does really prevent to use a standard signal delivery
> over fd for this usecase?

I wasn't part of the discussions on why things like WIPEONFORK were =

invented instead of just using signalling mechanisms, but the main =

reason I can think of are libraries.

As a library, you are under no control of the main loop usually, which =

means you just don't have a way to poll for an fd. As a library author, =

I would usually try to avoid very hard to create such a dependency, =

because it makes it really hard to glue pieces together.

The same applies to signals btw, which would also be a possible way to =

propagate such events.


Alex



Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879
