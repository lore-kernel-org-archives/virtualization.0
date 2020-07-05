From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 5/5] virtio_console: Constify some static variables
Date: Sun, 05 Jul 2020 13:50:32 -0700
Message-ID: <0334ec747d2e44a2ec3fd6147cfe139200d8b853.camel@perches.com>
References: <20200701200950.30314-1-rikard.falkeborn@gmail.com>
         <20200701200950.30314-6-rikard.falkeborn@gmail.com>
         <20200703175529.GE3150@trundl.on>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200703175529.GE3150@trundl.on>
Sender: linux-kernel-owner@vger.kernel.org
To: Amit Shah <amitshah@gmx.net>, Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Sun, 2020-07-05 at 20:30 +0200, Amit Shah wrote:
> On (Wed) 01 Jul 2020 [22:09:50], Rikard Falkeborn wrote:
> > The id_table and feature_table pointers in struct virtio_driver are
> > pointers to const. Mark the corresponding static variables const to
> > allow the compiler to put them in read-only memory.
> > 
> > Before:
> >    text    data     bss     dec     hex filename
> >   25447     713      76   26236    667c drivers/char/virtio_console.o
> > 
> > After:
> >    text    data     bss     dec     hex filename
> >   25488     673      76   26237    667d drivers/char/virtio_console.o
> > 
> > Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
> 
> Reviewed-by: Amit Shah <amit@kernel.org>
> 
> Please CC me on the entire series instead of individual patches in the
> future.

CC'ing individual maintainers on entire patch sets
that span multiple subsystems doesn't scale.

Given that lore.kernel.org now stores all emails
sent to lkml, it's a reasonable thing to add a
reference to the cover letter below the --- line
to make it easier for individual recipients of
patches in a series to find the entire patch set.

i.e. Send emails with something like:

Subject: [PATCH N/M] foo: bar

commit message

Signed-off-by: J. Random Developer <address@domain.tld>
---

Link: https://lore.kernel.org/r/<message_id_of_cover_letter>

[patch]

A trivial script to insert these links if all patches
in a series are stored in a separate directory:

$ bash insert_cover_letter_link.bash <patch_directory>

---
$ cat insert_cover_letter_link.bash
#!/bin/bash

find $@ -name "*.patch" | sort | \
    while read file ; do

	echo "File: <$file>"
	if [[ $(basename $file) =~ ^0000- ]] ; then
	    message_id=$(grep '^Message-Id: <' $file)
	    if [ $? -ne 0 ] ; then
		echo "Message_Id not found"
		exit 1
	    fi
	    message_id=$(echo $message_id | \
			     sed -r -e 's/^Message-Id:\s*<//' -e 's/>\s*$//')
	    separator="-- "
	    echo "Message_Id: <$message_id>"
	else
	    separator="---"
	fi
	
	if [[ "$message_id" == "" ]] ; then
	    echo "Patch series cover letter Message_Id not found"
	    exit 1
	fi

	perl -n -i -e "if (\$_ =~ /^$separator$/) { print; print \"\\n\"; print \"Link: https://lore.kernel.org/r/\" . '$message_id' . \"\\n\"; print \"\\n\"; } else { print; }" $file

    done

exit 0
