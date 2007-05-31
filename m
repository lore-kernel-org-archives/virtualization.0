From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [patch rfc wip] first cut of ELF bzImage
Date: Thu, 31 May 2007 00:43:30 -0700
Message-ID: <465E7CA2.6090201@zytor.com>
References: <465E78D2.9080609@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <465E78D2.9080609@goop.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Virtualization Mailing List <virtualization@lists.osdl.org>, Vivek Goyal <vgoyal@in.ibm.com>, "Eric W. Biederman" <ebiederm@xmission.com>
List-Id: virtualization@lists.linuxfoundation.org

The more I'm thinking about this whole issue, the more I'm thinking this
is really misdirected.

I'm starting to think that the right thing to do might very well be as
follows:

- Change the payload of the bzImage file from a flat binary to an ELF
  file -- a stripped vmlinux.gz.
- Change the decompressor to incorporate a (simple) ELF parser.
- Incorporate a couple of pointer fields in the bzImage header that
  points directly to the payload, the format of which can be identified
  via its magic number (currently gzip).

That way the environments that want to enter at the protected-mode
entrypoint can do their own setup using whatever information is retained
in the payload.  Since most of these environments are currently using
vmlinux as their boot file, this seems to make sense.

The more I hear about copying notes and various things from vmlinux to
bzImage the more I'm convinced that this is a huge kluge.  Furthermore,
there are *definitely* virtual environments which would be much happier
to be able to decompress in host space.  The decompressor doesn't run
well in many simulators.

	-hpa
